import '../../../../domain/entities/job_entity.dart';

abstract class GetPendingJobsViewModelStates {}
class GetPendingJobsViewModelInitial extends GetPendingJobsViewModelStates {}
class GetPendingJobsViewModelLoading extends GetPendingJobsViewModelStates {}
class GetPendingJobsViewModelSuccess extends GetPendingJobsViewModelStates {
  final List<JobEntity> jobs;
  GetPendingJobsViewModelSuccess(this.jobs);
}
class GetPendingJobsViewModelError extends GetPendingJobsViewModelStates {
  final String message;
  GetPendingJobsViewModelError(this.message);
}