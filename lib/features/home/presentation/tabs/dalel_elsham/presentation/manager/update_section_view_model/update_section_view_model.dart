import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/dalel_elsham/domain/use_case/dalel_al_sham_place_use_case/dalel_al_sham_place_use_case.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/dalel_elsham/presentation/manager/update_section_view_model/update_section_view_model_states.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/presentation/manager/project_display_section_view_model/update_project_display_section_view_model/update_project_display_section_view_model_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
@injectable
class UpdateSectionViewModel extends Cubit<UpdateSectionViewModelStates> {
  final DalelAlShamPlaceUseCase dalelAlShamPlaceUseCase;

  UpdateSectionViewModel(this.dalelAlShamPlaceUseCase)
    : super(UpdateSectionViewModelInitial());

  Future<void> updateSectionStatus(String sectionId, bool status) async {
    emit(UpdateSectionViewModelLoading());
    final result = await dalelAlShamPlaceUseCase.updateSectionStatus(
      sectionId,
      status,
    );
    result.fold(
      ifLeft: (failure) => emit(UpdateSectionViewModelError(failure.message)),
      ifRight: (success) => emit(UpdateSectionViewModelSuccess()),
    );
  }
}
