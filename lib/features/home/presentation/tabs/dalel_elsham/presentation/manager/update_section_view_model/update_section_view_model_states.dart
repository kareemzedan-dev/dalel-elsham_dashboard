abstract class UpdateSectionViewModelStates {}
class UpdateSectionViewModelInitial extends UpdateSectionViewModelStates {}
class UpdateSectionViewModelLoading extends UpdateSectionViewModelStates {}
class UpdateSectionViewModelError extends UpdateSectionViewModelStates {
  final String message;

  UpdateSectionViewModelError(this.message);
}
class UpdateSectionViewModelSuccess extends UpdateSectionViewModelStates {}