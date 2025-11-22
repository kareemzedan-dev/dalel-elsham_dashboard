abstract class AddProjectToSectionViewModelStates {}
class AddProjectToSectionViewModelInitial extends AddProjectToSectionViewModelStates {}
class AddProjectToSectionViewModelLoading extends AddProjectToSectionViewModelStates {}
class AddProjectToSectionViewModelSuccess extends AddProjectToSectionViewModelStates {}
class AddProjectToSectionViewModelError extends AddProjectToSectionViewModelStates {
  final String message;
  AddProjectToSectionViewModelError({required this.message});
}