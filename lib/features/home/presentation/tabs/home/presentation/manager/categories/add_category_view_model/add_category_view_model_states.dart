abstract class AddCategoryViewModelStates {}
class AddCategoryViewModelInitial extends AddCategoryViewModelStates {}

// -----------------------------
// 🔥 Success
// -----------------------------
class AddCategoryViewModelSuccess extends AddCategoryViewModelStates {}

// -----------------------------
// 🔥 Loading
// -----------------------------
class AddCategoryViewModelLoading extends AddCategoryViewModelStates {}

// -----------------------------
// 🔥 Error
// -----------------------------
class AddCategoryViewModelError extends AddCategoryViewModelStates {
  final String message;

  AddCategoryViewModelError(this.message);
}
