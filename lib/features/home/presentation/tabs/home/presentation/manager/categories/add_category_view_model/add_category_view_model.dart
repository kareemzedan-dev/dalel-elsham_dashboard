import 'package:dart_either/dart_either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../../../core/errors/failures.dart';
import '../../../../domain/entities/category_entity.dart';
import '../../../../domain/use_cases/category_use_case/category_use_case.dart';
import 'add_category_view_model_states.dart';
@injectable
class AddCategoryViewModel extends Cubit<AddCategoryViewModelStates> {
  final CategoryUseCase addCategoryUseCase;

  AddCategoryViewModel({required this.addCategoryUseCase})
    : super(AddCategoryViewModelInitial());

  Future<Either<Failures, void>> addCategory(CategoryEntity category) async {
    try {
      emit(AddCategoryViewModelLoading());
      final result = await addCategoryUseCase.addCategory(category);
      result.fold(
        ifLeft: (failure) => emit(AddCategoryViewModelError(failure.message)),
        ifRight: (success) => emit(AddCategoryViewModelSuccess()),
      );
      return result;
    } catch (e) {
      emit(AddCategoryViewModelError(e.toString()));
      return Left(ServerFailure(e.toString()));
    }
  }
}
