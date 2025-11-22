abstract class UpdateCategoryViewModelStates {}

class UpdateCategoryViewModelInitial extends UpdateCategoryViewModelStates {}

class UpdateCategoryViewModelLoading extends UpdateCategoryViewModelStates {}

class UpdateCategoryViewModelError extends UpdateCategoryViewModelStates {
  final String message;

  UpdateCategoryViewModelError(this.message);
}

class UpdateCategoryViewModelSuccess extends UpdateCategoryViewModelStates {

}
