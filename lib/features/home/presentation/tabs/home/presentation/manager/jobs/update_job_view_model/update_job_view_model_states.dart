abstract class UpdateJobViewModelStates {}
class UpdateJobViewModelInitial extends UpdateJobViewModelStates {}
class UpdateJobViewModelLoading extends UpdateJobViewModelStates {}
class UpdateJobViewModelSuccess extends UpdateJobViewModelStates {}
class UpdateJobViewModelError extends UpdateJobViewModelStates {
  final String message;

  UpdateJobViewModelError(this.message);
}