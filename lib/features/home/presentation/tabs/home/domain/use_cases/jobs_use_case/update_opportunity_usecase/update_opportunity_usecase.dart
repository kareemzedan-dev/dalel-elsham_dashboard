import 'package:dart_either/dart_either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../../../core/errors/failures.dart';
import '../../../entities/job_entity.dart';
import '../../../repos/job/update_opportunity_repo/update_opportunity_repo.dart';

@injectable
 class UpdateOpportunityUseCase {
   final UpdateOpportunityRepo updateOpportunityRepo;

   UpdateOpportunityUseCase(this.updateOpportunityRepo);

   Future<Either<Failures, void>> updateOpportunity(JobEntity jobEntity) async {
     return await updateOpportunityRepo.updateOpportunity(jobEntity);
   }
 }