import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/repos/job/get_all_opportunities_repo/get_all_opportunities_repo.dart';
import 'get_pending_opportunity_view_model_states.dart';
@injectable
class GetPendingOpportunityViewModel extends Cubit<GetPendingOpportunityViewModelStates>{
  final GetAllOpportunitiesRepo getAllOpportunitiesRepo;
  GetPendingOpportunityViewModel(this.getAllOpportunitiesRepo):super(GetPendingOpportunityViewModelInitial());

  Future<void> getPendingOpportunities() async {
    emit(GetPendingOpportunityViewModelLoading());
    final result = await getAllOpportunitiesRepo.getPendingOpportunities();
    result.fold(
      ifLeft: (fail) => emit(GetPendingOpportunityViewModelError(fail.message)),
      ifRight: (jobs) => emit(GetPendingOpportunityViewModelSuccess(jobs)),
    );
  }
}