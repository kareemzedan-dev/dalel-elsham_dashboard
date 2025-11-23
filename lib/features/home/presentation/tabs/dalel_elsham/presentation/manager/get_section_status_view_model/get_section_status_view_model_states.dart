abstract class GetSectionStatusViewModelStates {}
class GetSectionStatusViewModelInitial extends GetSectionStatusViewModelStates {}
class GetSectionStatusViewModelLoading extends GetSectionStatusViewModelStates {}
class GetSectionStatusViewModelError extends GetSectionStatusViewModelStates {
  final String message;

  GetSectionStatusViewModelError(this.message);
}
class GetSectionStatusViewModelSuccess extends GetSectionStatusViewModelStates {
  final bool status;

  GetSectionStatusViewModelSuccess(this.status);
}