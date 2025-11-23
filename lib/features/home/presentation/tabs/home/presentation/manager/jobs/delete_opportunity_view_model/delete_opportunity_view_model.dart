import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/repos/job/delete_job_repo/delete_job_repo.dart';
import 'delete_opportunity_view_model_states.dart';

@injectable
class DeleteOpportunityViewModel
    extends Cubit<DeleteOpportunityViewModelStates> {
  final DeleteJobRepo deleteJobRepo;

  DeleteOpportunityViewModel(this.deleteJobRepo)
    : super(DeleteOpportunityViewModelInitial());

  Future<void> deleteOpportunity(String opportunityId) async {
    emit(DeleteOpportunityViewModelLoading());
    final result = await deleteJobRepo.deleteOpportunity(opportunityId);
    result.fold(
      ifLeft: (fail) => emit(DeleteOpportunityViewModelError(fail.message)),
      ifRight: (success) => emit(DeleteOpportunityViewModelSuccess()),
    );
  }
}
