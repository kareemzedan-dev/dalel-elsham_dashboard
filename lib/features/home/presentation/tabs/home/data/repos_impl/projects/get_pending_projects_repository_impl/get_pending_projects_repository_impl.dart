 import 'package:dart_either/dart_either.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/domain/repos/projects/get_pending_projects_repository/get_pending_projects_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../../../core/errors/failures.dart';
import '../../../../domain/entities/project_entity.dart';
import '../../../data_sources/remote/projects/get_pending_projects_remote_data_source/get_pending_projects_remote_data_source.dart';
@Injectable(as: GetPendingProjectsRepository)
class GetPendingProjectsRepositoryImpl implements GetPendingProjectsRepository {
  final GetPendingProjectsRemoteDataSource getPendingProjectsRemoteDataSource;
  GetPendingProjectsRepositoryImpl(this.getPendingProjectsRemoteDataSource);

  @override
  Future<Either<Failures, List<ProjectEntity>>> getPendingProjects() {
    return getPendingProjectsRemoteDataSource.getPendingProjects();
  }
}