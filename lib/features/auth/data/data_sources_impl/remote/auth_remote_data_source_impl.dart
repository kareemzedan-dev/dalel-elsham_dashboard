import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dart_either/dart_either.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/cache/shared_preferences.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/errors/firebase_auth_error_mapper.dart';
import '../../../../../core/services/firebase_service.dart';
import '../../../domain/entities/auth_entity.dart';
import '../../data_sources/remote/auth_remote_data_source.dart';
import '../../model/auth_model.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseService firebaseService;

  AuthRemoteDataSourceImpl(this.firebaseService);

  // ------------------------------------------------------
  // 🔵 REGISTER (Admins Only)
  // ------------------------------------------------------
  @override
  Future<Either<Failures, AuthEntity>> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user!;
      final uid = user.uid;

      final userData = AuthModel(
        id: uid,
        name: name,
        email: email,
        phone: phone,
        profileImage: "",
      );

      final fcmToken = await FirebaseMessaging.instance.getToken();

      // ⭐ Save admin profile
      await _firestore.collection("users").doc(uid).set({
        ...userData.toMap(),
        "role": "admin",   // ⭐ الآن هذا المستخدم يعتبر Admin
        "fcmToken": fcmToken,
      });

      final token = await user.getIdToken(true);

      // ⭐ Save to device
      await SharedPrefHelper.setString("auth_token", token!);
      await SharedPrefHelper.setString("user_name", name);
      await SharedPrefHelper.setString("user_email", email);
      await SharedPrefHelper.setString("user_phone", phone);
      await SharedPrefHelper.setString("user_role", "admin"); // ⭐

      return Right(userData);
    } catch (e) {
      final msg = FirebaseAuthErrorMapper.fromExceptionMessage(e.toString());
      return Left(ServerFailure(msg));
    }
  }

  // ------------------------------------------------------
  // 🔵 LOGIN
  // ------------------------------------------------------
  @override
  Future<Either<Failures, AuthEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user!;
      final uid = user.uid;

      final doc = await _firestore.collection("users").doc(uid).get();

      if (!doc.exists) {
        return Left(ServerFailure("User profile not found."));
      }

      final data = doc.data()!;
      final authUser = AuthModel.fromMap(data, doc.id);

      final token = await user.getIdToken(true);
      final fcmToken = await FirebaseMessaging.instance.getToken();

      // ⭐ Get role
      final role = data["role"] ?? "user";

      // ⭐ Save in device
      await SharedPrefHelper.setString("auth_token", token!);
      await SharedPrefHelper.setString("user_name", authUser.name);
      await SharedPrefHelper.setString("user_email", email);
      await SharedPrefHelper.setString("user_role", role); // ⭐ important!!

      // Update FCM Token
      await _firestore.collection("users").doc(uid).update({
        "fcmToken": fcmToken,
      });

      return Right(authUser);
    } catch (e) {
      final msg = FirebaseAuthErrorMapper.fromExceptionMessage(e.toString());
      return Left(ServerFailure(msg));
    }
  }

  // ------------------------------------------------------
  // 🔵 GET CURRENT USER
  // ------------------------------------------------------
  @override
  Future<Either<Failures, AuthEntity>> getCurrentUser() async {
    try {
      final user = _auth.currentUser;

      if (user == null) {
        return Left(ServerFailure("No logged-in user."));
      }

      final doc = await _firestore.collection("users").doc(user.uid).get();

      if (!doc.exists) {
        return Left(ServerFailure("User profile not found."));
      }

      return Right(AuthModel.fromMap(doc.data()!, doc.id));
    } catch (e) {
      final msg = FirebaseAuthErrorMapper.fromExceptionMessage(e.toString());
      return Left(ServerFailure(msg));
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _auth.signOut();
      await SharedPrefHelper.remove("auth_token");
      await SharedPrefHelper.remove("user_role");
    } catch (e) {
      final readable = FirebaseAuthErrorMapper.fromExceptionMessage(
        e.toString(),
      );
      throw ServerFailure(readable);
    }
  }
}
