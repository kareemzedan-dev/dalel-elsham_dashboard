import 'package:dart_either/dart_either.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../../../../core/errors/failures.dart';
import '../../../../../../../../../core/helper/network_validation.dart';
import '../../../../../../../../../core/services/firebase_service.dart';
import '../../../../domain/entities/category_entity.dart';
import '../../../data_sources/remote/category_remote_data_source/category_remote_data_source.dart';
import '../../../models/category_model.dart';

@Injectable(as: CategoryRemoteDataSource)
class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final FirebaseService firebaseService;

  CategoryRemoteDataSourceImpl(this.firebaseService);

  @override
  Future<Either<Failures, List<CategoryEntity>>> getAllCategories() async {
    try {
      if (!await NetworkValidation.hasInternet()) {
        return Left(NetworkFailure("لا يوجد اتصال بالانترنت"));
      }

      final data = await firebaseService.getCollection(
        collection: "categories",
      );

      final categories = data.map((item) {
        return CategoryModel.fromMap(item, item["id"]);
      }).toList();

      return Right(categories);

    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // ===========================================================
  // 🔥 1) إضافة فئة جديدة
  // ===========================================================
  @override
  Future<Either<Failures, void>> addCategory(CategoryEntity category) async {
    try {
      if (!await NetworkValidation.hasInternet()) {
        return Left(NetworkFailure("لا يوجد اتصال بالانترنت"));
      }

      final model = CategoryModel.fromEntity(category);

      await firebaseService.addDocument(
        collection: "categories",
        data: model.toMap(),
        docId: model.id,
      );

      return const Right(null);

    } catch (e) {
      return Left(ServerFailure("فشل إضافة الفئة: $e"));
    }
  }

  // ===========================================================
  // 🔥 2) تحديث فئة
  // ===========================================================
  @override
  Future<Either<Failures, void>> updateCategory(CategoryEntity category) async {
    try {
      if (!await NetworkValidation.hasInternet()) {
        return Left(NetworkFailure("لا يوجد اتصال بالانترنت"));
      }

      final model = CategoryModel.fromEntity(category);

      await firebaseService.updateDocument(
        collection: "categories",
        docId: model.id,
        data: model.toMap(),
      );

      return const Right(null);

    } catch (e) {
      return Left(ServerFailure("فشل تحديث الفئة: $e"));
    }
  }

  // ===========================================================
  // 🔥 3) حذف فئة
  // ===========================================================
  @override
  Future<Either<Failures, void>> deleteCategory(String categoryId) async {
    try {
      if (!await NetworkValidation.hasInternet()) {
        return Left(NetworkFailure("لا يوجد اتصال بالانترنت"));
      }

      await firebaseService.deleteDocument(
        collection: "categories",
        docId: categoryId,
      );

      return const Right(null);

    } catch (e) {
      return Left(ServerFailure("فشل حذف الفئة: $e"));
    }
  }
}
