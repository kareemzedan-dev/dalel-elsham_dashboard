import '../../../../domain/entities/job_entity.dart';

abstract class GetPendingOpportunityViewModelStates {}
class GetPendingOpportunityViewModelInitial extends GetPendingOpportunityViewModelStates {}
class GetPendingOpportunityViewModelLoading extends GetPendingOpportunityViewModelStates {}
class GetPendingOpportunityViewModelSuccess extends GetPendingOpportunityViewModelStates {
  final List<JobEntity> jobs;
  GetPendingOpportunityViewModelSuccess(this.jobs);
}
class GetPendingOpportunityViewModelError extends GetPendingOpportunityViewModelStates {
  final String message;
  GetPendingOpportunityViewModelError(this.message);
}
