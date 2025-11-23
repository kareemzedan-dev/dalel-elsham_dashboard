import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/repos/job/get_all_jobs_repo/get_all_jobs_repo.dart';
import 'get_pending_jobs_view_model_states.dart';
@injectable
class GetPendingJobsViewModel extends Cubit<GetPendingJobsViewModelStates>{
  final GetAllJobsRepo getAllJobsRepo;
  GetPendingJobsViewModel(this.getAllJobsRepo):super(GetPendingJobsViewModelInitial());

  Future<void> getPendingJobs() async {
    emit(GetPendingJobsViewModelLoading());
    final result = await getAllJobsRepo.getPendingJobs();
    result.fold(
      ifLeft: (fail) => emit(GetPendingJobsViewModelError(fail.message)),
      ifRight: (jobs) => emit(GetPendingJobsViewModelSuccess(jobs)),
    );
  }

}