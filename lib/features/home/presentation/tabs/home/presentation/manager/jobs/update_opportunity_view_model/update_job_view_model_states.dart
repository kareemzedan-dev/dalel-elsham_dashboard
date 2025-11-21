 abstract class UpdateOpportunityViewModelStates {}
 class UpdateOpportunityViewModelInitial extends UpdateOpportunityViewModelStates {}
 class UpdateOpportunityViewModelLoading extends UpdateOpportunityViewModelStates {}
 class UpdateOpportunityViewModelSuccess extends UpdateOpportunityViewModelStates {}
 class UpdateOpportunityViewModelError extends UpdateOpportunityViewModelStates {
   final String message;

   UpdateOpportunityViewModelError(this.message);
 }