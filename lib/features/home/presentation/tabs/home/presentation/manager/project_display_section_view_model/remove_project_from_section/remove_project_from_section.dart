import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/domain/use_cases/project_display_sections_use_case/project_display_sections_use_case.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/presentation/manager/project_display_section_view_model/remove_project_from_section/remove_project_from_section_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
@injectable
class RemoveProjectFromSectionViewModel extends Cubit<RemoveProjectFromSectionStates> {
  final ProjectDisplaySectionsUseCase projectDisplaySectionsUseCase;

  RemoveProjectFromSectionViewModel(this.projectDisplaySectionsUseCase)
    : super(RemoveProjectFromSectionLoading());

  Future<void> removeProjectFromSection(
    String projectId,
    String sectionId,
  ) async {
    emit(RemoveProjectFromSectionLoading());
    final result = await projectDisplaySectionsUseCase.removeProjectFromSection(
      projectId,
      sectionId,
    );
    result.fold(
      ifLeft: (fail) => emit(RemoveProjectFromSectionError(fail.message)),
      ifRight: (success) => emit(RemoveProjectFromSectionSuccess()),
    );
  }
}
