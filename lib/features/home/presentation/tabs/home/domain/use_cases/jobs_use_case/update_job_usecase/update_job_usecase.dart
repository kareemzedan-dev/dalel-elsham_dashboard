import 'package:dart_either/dart_either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../../../core/errors/failures.dart';
import '../../../entities/job_entity.dart';
import '../../../repos/job/update_job_repo/update_job_repo.dart';
@injectable
 class UpdateJobUsecase {
   final UpdateJobRepo updateJobRepo;
   UpdateJobUsecase(this.updateJobRepo);
   Future<Either<Failures, void>> updateJob(JobEntity jobEntity) {
     return updateJobRepo.updateJob(jobEntity);
   }
 }