import 'package:dart_either/dart_either.dart';
import 'package:dlyl_alsham_dashboard/core/errors/failures.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/domain/use_cases/jobs_use_case/update_job_usecase/update_job_usecase.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/presentation/manager/jobs/update_job_view_model/update_job_view_model_states.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/presentation/manager/jobs/update_opportunity_view_model/update_job_view_model_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/job_entity.dart';
import '../../../../domain/use_cases/jobs_use_case/update_opportunity_usecase/update_opportunity_usecase.dart';

@injectable
 class UpdateOpportunityViewModel extends Cubit<UpdateOpportunityViewModelStates> {
   final UpdateOpportunityUseCase updateOpportunityUseCase;

   UpdateOpportunityViewModel(this.updateOpportunityUseCase)
     : super(UpdateOpportunityViewModelInitial());

   Future<Either<Failures, void>> updateOpportunity(JobEntity jobEntity) async {
     try {
       emit(UpdateOpportunityViewModelLoading());
       final result = await updateOpportunityUseCase.updateOpportunity(jobEntity);
       result.fold(
         ifLeft: (failure) => emit(UpdateOpportunityViewModelError(failure.message)),

         ifRight: (success) => emit(UpdateOpportunityViewModelSuccess()),
       );
       return result;
     } catch (e) {
       emit(UpdateOpportunityViewModelError(e.toString()));
       return Left(ServerFailure(e.toString()));
     }
   }
 }