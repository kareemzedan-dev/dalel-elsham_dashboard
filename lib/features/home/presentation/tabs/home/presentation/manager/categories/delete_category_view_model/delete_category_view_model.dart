import 'package:dart_either/dart_either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../../../core/errors/failures.dart';
import '../../../../domain/use_cases/category_use_case/category_use_case.dart';
import 'delete_category_view_model_states.dart';
@injectable
class DeleteCategoryViewModel extends Cubit<DeleteCategoryViewModelStates> {
  final CategoryUseCase deleteCategoryUseCase;

  DeleteCategoryViewModel({required this.deleteCategoryUseCase}) : super(DeleteCategoryViewModelInitial());

  Future<Either<Failures, void>> deleteCategory(String categoryId) async {
    try {
      emit(DeleteCategoryViewModelLoading());
      final result = await deleteCategoryUseCase.deleteCategory(categoryId);
      result.fold(
        ifLeft: (failure) => emit(DeleteCategoryViewModelError(failure.message)),
        ifRight: (success) => emit(DeleteCategoryViewModelSuccess()),
      );
      return result;
    } catch (e) {
      emit(DeleteCategoryViewModelError(e.toString()));
      return Left(ServerFailure(e.toString()));
    }
  }
}