import 'package:dart_either/dart_either.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/dalel_elsham/presentation/manager/get_section_status_view_model/get_section_status_view_model_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../../core/errors/failures.dart';
import '../../../domain/use_case/dalel_al_sham_place_use_case/dalel_al_sham_place_use_case.dart';

@injectable
class GetSectionStatusViewModel extends Cubit<GetSectionStatusViewModelStates> {
  final DalelAlShamPlaceUseCase dalelAlShamPlaceUseCase;

  GetSectionStatusViewModel(this.dalelAlShamPlaceUseCase)
    : super(GetSectionStatusViewModelInitial());

  Future<Either<Failures, bool>> getSectionStatus(String sectionId) async {
    try {
      emit(GetSectionStatusViewModelLoading());
      final result = await dalelAlShamPlaceUseCase.getSectionStatus(sectionId);
      result.fold(
        ifLeft: (failure) =>
            emit(GetSectionStatusViewModelError(failure.message)),
        ifRight: (success) => emit(GetSectionStatusViewModelSuccess(success)),
      );
      return result;
    } catch (e) {
      emit(GetSectionStatusViewModelError(e.toString()));
      return Left(ServerFailure(e.toString()));
    }
  }
}
