import '../../../../domain/entities/project_entity.dart';

abstract class GetPendingProjectsViewModelStates {}
class GetPendingProjectsViewModelInitial extends GetPendingProjectsViewModelStates {}
class GetPendingProjectsViewModelLoading extends GetPendingProjectsViewModelStates {}
class GetPendingProjectsViewModelSuccess extends GetPendingProjectsViewModelStates {
  final List<ProjectEntity> projects;

  GetPendingProjectsViewModelSuccess(this.projects);
}
class GetPendingProjectsViewModelError extends GetPendingProjectsViewModelStates {
  final String message;

  GetPendingProjectsViewModelError(this.message);
}

