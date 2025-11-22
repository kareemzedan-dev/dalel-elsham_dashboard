import 'package:dart_either/dart_either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../../../../core/errors/failures.dart';
import '../../../../../../../../../../core/helper/network_validation.dart';
import '../../../../../../../../../../core/services/firebase_service.dart';
import '../../../../../domain/entities/project_entity.dart';
import '../../../../data_sources/remote/projects/get_pending_projects_remote_data_source/get_pending_projects_remote_data_source.dart';
import '../../../../models/project_model.dart';
@Injectable(as: GetPendingProjectsRemoteDataSource)
class GetAllProjectsRemoteDataSourceImpl
    implements GetPendingProjectsRemoteDataSource {
  final FirebaseService fireStoreService;

  GetAllProjectsRemoteDataSourceImpl(this.fireStoreService);

  @override
  Future<Either<Failures, List<ProjectEntity>>> getPendingProjects() async {
    try {
      if (!await NetworkValidation.hasInternet()) {
        return Left(NetworkFailure("لا يوجد اتصال بالإنترنت"));
      }

      final List<Map<String, dynamic>> rawData =
      await fireStoreService.getCollection(collection: "projects");

      final projects = rawData.map((data) {
        return ProjectModel.fromMap(
          data,
          data['id'] ?? "",
        );
      }).toList();

      // ⚠️ هنا الفلترة على المشاريع اللي حالتها pending
      final pendingProjects = projects
          .where((project) => project.status == "pending")
          .toList();

      return Right(pendingProjects);
    } catch (e) {
      return Left(ServerFailure("حدث خطأ أثناء جلب المشاريع: $e"));
    }
  }
}
