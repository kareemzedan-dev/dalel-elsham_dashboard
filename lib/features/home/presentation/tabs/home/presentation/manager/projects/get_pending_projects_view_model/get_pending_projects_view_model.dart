import 'package:dart_either/dart_either.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/domain/use_cases/projects/get_pending_projects_usecase/get_pending_projects_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../../../core/errors/failures.dart';
import '../../../../domain/entities/project_entity.dart';
import 'get_pending_projects_view_model_states.dart';
@injectable
class GetPendingProjectsViewModel extends Cubit<GetPendingProjectsViewModelStates> {
  final GetPendingProjectsUsecase getPendingProjectsUsecase;

  /// 🔥 نخزن البيانات الأصلية هنا
  List<ProjectEntity> allProjects = [];

  GetPendingProjectsViewModel(this.getPendingProjectsUsecase)
      : super(GetPendingProjectsViewModelInitial());

  Future<void> getPendingProjects() async {
    try {
      emit(GetPendingProjectsViewModelLoading());

      final result = await getPendingProjectsUsecase.getPendingProjects();

      result.fold(
        ifLeft: (fail) => emit(GetPendingProjectsViewModelError(fail.message)),
        ifRight: (value) {
          allProjects = value;     // حفظ المشاريع الأصلية
          emit(GetPendingProjectsViewModelSuccess(value));
        },
      );
    } catch (e) {
      emit(GetPendingProjectsViewModelError(e.toString()));
    }
  }

  /// 🔎 البحث
  void searchProjects(String query) {
    if (query.trim().isEmpty) {
      emit(GetPendingProjectsViewModelSuccess(allProjects));
      return;
    }

    final filtered = allProjects.where((project) {
      final title = project.title.toLowerCase();
      final description = project.description.toLowerCase();
      final q = query.toLowerCase();

      return title.contains(q) || description.contains(q);
    }).toList();

    emit(GetPendingProjectsViewModelSuccess(filtered));
  }
}
