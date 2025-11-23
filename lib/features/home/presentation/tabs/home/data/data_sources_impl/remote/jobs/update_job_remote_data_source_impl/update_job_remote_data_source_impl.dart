import 'package:dart_either/dart_either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../../../../core/errors/failures.dart';
import '../../../../../../../../../../core/helper/network_validation.dart';
import '../../../../../../../../../../core/services/firebase_service.dart';
import '../../../../models/job_model.dart';
import '../../../../../domain/entities/job_entity.dart';
import '../../../../data_sources/remote/jobs/update_job_remote_data_source/update_job_remote_data_source.dart';
import '../../../../../../../../../../core/services/notification_service.dart';

@Injectable(as: UpdateJobRemoteDataSource)
class UpdateJobRemoteDataSourceImpl implements UpdateJobRemoteDataSource {
  final FirebaseService firebaseService;

  UpdateJobRemoteDataSourceImpl(this.firebaseService);

  @override
  Future<Either<Failures, void>> updateJob(JobEntity jobEntity) async {
    try {
      if (!await NetworkValidation.hasInternet()) {
        return Left(NetworkFailure("لا يوجد اتصال بالانترنت"));
      }

      final updatedModel = JobModel(
        id: jobEntity.id,
        title: jobEntity.title,
        description: jobEntity.description,
        type: jobEntity.type,
        phone: jobEntity.phone,
        location: jobEntity.location,
        imageUrl: jobEntity.imageUrl,
        isActive: jobEntity.isActive,
        duration: jobEntity.duration,
        createdAt: jobEntity.createdAt,
        status: jobEntity.status,
        userId: jobEntity.userId,  // ⭐ مهم جداً
      );

      // 🔥 1) Update job
      await firebaseService.updateDocument(
        collection: "jobs",
        docId: jobEntity.id,
        data: updatedModel.toMap(),
      );

      // 🔥 2) Get user data
      if (jobEntity.userId != null && jobEntity.userId!.isNotEmpty) {
        final userData = await firebaseService.getDocument(
          collection: "users",
          docId: jobEntity.userId!,
        );

        if (userData != null) {
          final fcmToken = userData["fcmToken"];

          if (fcmToken != null && fcmToken.isNotEmpty) {
            // تحديد الإشعار بناءً على الحالة
            String title = "";
            String msg = "";

            switch (jobEntity.status) {
              case "approved":
                title = "🎉 وظيفتك اتقبلت!";
                msg = "تمت الموافقة على إعلان الوظيفة (${jobEntity.title}).";
                break;

              case "rejected":
                title = "❗ نأسف لذلك";
                msg =
                "تم رفض إعلان الوظيفة (${jobEntity.title}). برجاء مراجعة البيانات.";
                break;

              default:
              // مفيش إشعار لباقي الحالات
                break;
            }

            if (title.isNotEmpty) {
              await NotificationService.sendToToken(
                token: fcmToken,
                title: title,
                message: msg,
              );
            }
          }
        }
      }

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
