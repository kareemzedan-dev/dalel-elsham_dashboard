abstract class DeleteJobViewModelStates {}
class DeleteJobViewModelInitial extends DeleteJobViewModelStates{}
class DeleteJobViewModelLoading extends DeleteJobViewModelStates {}
class DeleteJobViewModelSuccess extends DeleteJobViewModelStates {}
class DeleteJobViewModelError extends DeleteJobViewModelStates {
  final String message;
  DeleteJobViewModelError({required this.message});
}
