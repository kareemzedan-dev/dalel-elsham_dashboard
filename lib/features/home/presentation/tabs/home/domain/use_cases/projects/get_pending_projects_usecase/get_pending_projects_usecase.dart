import 'package:dart_either/dart_either.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/domain/repos/projects/get_pending_projects_repository/get_pending_projects_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../../../core/errors/failures.dart';
import '../../../entities/project_entity.dart';
@injectable
class GetPendingProjectsUsecase {
  final GetPendingProjectsRepository getPendingProjectsRepository;
  GetPendingProjectsUsecase(this.getPendingProjectsRepository);
  Future<Either<Failures, List<ProjectEntity>>> getPendingProjects() {
    return getPendingProjectsRepository.getPendingProjects();
  }
}