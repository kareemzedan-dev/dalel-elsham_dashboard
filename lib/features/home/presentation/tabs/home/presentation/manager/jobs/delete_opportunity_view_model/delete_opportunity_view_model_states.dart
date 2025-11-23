abstract class DeleteOpportunityViewModelStates {}

class DeleteOpportunityViewModelInitial extends DeleteOpportunityViewModelStates {}
class DeleteOpportunityViewModelLoading extends DeleteOpportunityViewModelStates {}
class DeleteOpportunityViewModelSuccess extends DeleteOpportunityViewModelStates {

}
class DeleteOpportunityViewModelError extends DeleteOpportunityViewModelStates {
  final String message;
  DeleteOpportunityViewModelError(this.message);
}
