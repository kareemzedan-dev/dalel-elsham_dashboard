import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/domain/use_cases/projects/add_project_usecase/add_project_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/project_entity.dart';
import '../../../../domain/use_cases/project_display_sections_use_case/project_display_sections_use_case.dart';
import 'add_project_to_section_view_model_states.dart';
@injectable
class AddProjectToSectionViewModel
    extends Cubit<AddProjectToSectionViewModelStates> {

  final ProjectDisplaySectionsUseCase addProjectToSectionUseCase;

  AddProjectToSectionViewModel(this.addProjectToSectionUseCase)
      : super(AddProjectToSectionViewModelInitial());

  Future<void> addProjectToSection({
    required String projectId,
    required String sectionId,
  }) async {
    emit(AddProjectToSectionViewModelLoading());

    final result = await addProjectToSectionUseCase.addProjectToSection(
      projectId,
      sectionId,
    );

    result.fold(
      ifLeft: (fail) =>
          emit(AddProjectToSectionViewModelError(message: fail.message)),
      ifRight: (_) =>
          emit(AddProjectToSectionViewModelSuccess()),
    );
  }
}
