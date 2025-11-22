abstract class DeleteCategoryViewModelStates {}

class DeleteCategoryViewModelInitial extends DeleteCategoryViewModelStates {}

class DeleteCategoryViewModelLoading extends DeleteCategoryViewModelStates {}

class DeleteCategoryViewModelError extends DeleteCategoryViewModelStates {
  final String message;

  DeleteCategoryViewModelError(this.message);
}

class DeleteCategoryViewModelSuccess extends DeleteCategoryViewModelStates {


}
