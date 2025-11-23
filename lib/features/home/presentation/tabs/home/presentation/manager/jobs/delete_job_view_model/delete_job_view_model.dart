import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/repos/job/delete_job_repo/delete_job_repo.dart';
import 'delete_job_view_model_states.dart';
@injectable
class DeleteJobViewModel extends Cubit<DeleteJobViewModelStates> {
  final DeleteJobRepo deleteJobRepo ;
  DeleteJobViewModel(this.deleteJobRepo) : super(DeleteJobViewModelInitial());

  Future<void> deleteJob(String jobId) async {
    emit(DeleteJobViewModelLoading());
    final result = await deleteJobRepo.deleteJob(jobId);
    result.fold(
      ifLeft: (fail) => emit(DeleteJobViewModelError(message:  fail.message)),
      ifRight: (success) => emit(DeleteJobViewModelSuccess()),
    );
  }
}