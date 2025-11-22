import 'package:dart_either/dart_either.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/presentation/manager/categories/update_category_view_model/update_category_view_model_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../../../core/errors/failures.dart';
import '../../../../domain/entities/category_entity.dart';
import '../../../../domain/use_cases/category_use_case/category_use_case.dart';

@injectable
class UpdateCategoryViewModel extends Cubit<UpdateCategoryViewModelStates> {
  final CategoryUseCase updateCategoryUseCase;

  UpdateCategoryViewModel({required this.updateCategoryUseCase})
    : super(UpdateCategoryViewModelInitial());

  Future<Either<Failures, void>> updateCategory(CategoryEntity category) async {
    try {
      emit(UpdateCategoryViewModelLoading());
      final result = await updateCategoryUseCase.updateCategory(category);
      result.fold(
        ifLeft: (failure) =>
            emit(UpdateCategoryViewModelError(failure.message)),
        ifRight: (success) => emit(UpdateCategoryViewModelSuccess()),
      );
      return result;
    } catch (e) {
      emit(UpdateCategoryViewModelError(e.toString()));
      return Left(ServerFailure(e.toString()));
    }
  }
}
