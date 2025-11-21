import 'package:dart_either/dart_either.dart';
import 'package:dlyl_alsham_dashboard/core/errors/failures.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/domain/use_cases/jobs_use_case/update_job_usecase/update_job_usecase.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/presentation/manager/jobs/update_job_view_model/update_job_view_model_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/job_entity.dart';

@injectable
class UpdateJobViewModel extends Cubit<UpdateJobViewModelStates> {
  final UpdateJobUsecase updateJobUsecase;

  UpdateJobViewModel(this.updateJobUsecase)
    : super(UpdateJobViewModelInitial());

  Future<Either<Failures, void>> updateJob(JobEntity jobEntity) async {
    try {
      emit(UpdateJobViewModelLoading());
      final result = await updateJobUsecase.updateJob(jobEntity);
      result.fold(
        ifLeft: (failure) => emit(UpdateJobViewModelError(failure.message)),

        ifRight: (success) => emit(UpdateJobViewModelSuccess()),
      );
      return result;
    } catch (e) {
      emit(UpdateJobViewModelError(e.toString()));
      return Left(ServerFailure(e.toString()));
    }
  }
}
