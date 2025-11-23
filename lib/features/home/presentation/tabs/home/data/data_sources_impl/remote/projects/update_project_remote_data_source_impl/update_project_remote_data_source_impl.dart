import 'package:dart_either/dart_either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../../../../core/errors/failures.dart';
import '../../../../../../../../../../core/helper/network_validation.dart';
import '../../../../../../../../../../core/services/firebase_service.dart';
import '../../../../../domain/entities/project_entity.dart';
import '../../../../models/project_model.dart';
import '../../../../data_sources/remote/projects/update_project_remote_data_source/update_project_remote_data_source.dart';
import '../../../../../../../../../../core/services/notification_service.dart';

@Injectable(as: UpdateProjectRemoteDataSource)
class UpdateProjectRemoteDataSourceImpl
    implements UpdateProjectRemoteDataSource {
  final FirebaseService fireStoreService;

  UpdateProjectRemoteDataSourceImpl(this.fireStoreService);

  @override
  Future<Either<Failures, void>> updateProject(ProjectEntity project) async {
    try {
      // 🔍 1) Check connection
      if (!await NetworkValidation.hasInternet()) {
        return Left(NetworkFailure("لا يوجد اتصال بالإنترنت"));
      }

      // 🛠 2) تحويل إلى Model
      final model = ProjectModel(
        id: project.id,
        title: project.title,
        description: project.description,
        categoryTitle: project.categoryTitle,
        phone: project.phone,
        location: project.location,
        logo: project.logo,
        images: project.images,
        additionalImages: project.additionalImages,
        duration: project.duration,
        createdAt: project.createdAt,
        status: project.status,
        isActive: project.isActive,
        tier: project.tier,
        mapLink: project.mapLink,
        whatsapp: project.whatsapp,
        facebook: project.facebook,
        instagram: project.instagram,
        website: project.website,
        views: project.views,
        workTimeFrom: project.workTimeFrom,
        workTimeTo: project.workTimeTo,
        viewCountOn: project.viewCountOn,
        displaySections: project.displaySections,
        userId: project.userId,
      );

      // 📝 3) تحديث المشروع
      await fireStoreService.updateDocument(
        collection: "projects",
        docId: project.id,
        data: model.toMap(),
      );

      // ⭐ 4) جلب بيانات صاحب المشروع
      final userData = await fireStoreService.getDocument(
        collection: "users",
        docId: project.userId,
      );

      if (userData != null) {
        final fcmToken = userData["fcmToken"];

        if (fcmToken != null && fcmToken.isNotEmpty) {
          String title = "";
          String msg = "";

          // 🎯 تحديد الإشعار بناءاً على حالة المشروع
          switch (project.status) {
            case "approved":
              title = "🎉 تهانينا!";
              msg =
              "تمت الموافقة على مشروعك (${project.title}) بنجاح! شكرًا لثقتك بنا.";
              break;

            case "rejected":
              title = "❗ نأسف لذلك";
              msg =
              "عذرًا، تم رفض مشروعك (${project.title}). برجاء مراجعة البيانات والمحاولة مرة أخرى.";
              break;

            default:
            // لو الحالة مش approved ولا rejected → مفيش إشعار
              return const Right(null);
          }

          // 🔔 إرسال الإشعار
          await NotificationService.sendToToken(
            token: fcmToken,
            title: title,
            message: msg,
          );
        }
      }

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure("فشل في تعديل المشروع: $e"));
    }
  }
}
