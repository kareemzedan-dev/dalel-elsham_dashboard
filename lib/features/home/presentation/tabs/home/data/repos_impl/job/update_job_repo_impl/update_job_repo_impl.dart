import 'package:dart_either/dart_either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../../../core/errors/failures.dart';
import '../../../../domain/entities/job_entity.dart';
import '../../../../domain/repos/job/update_job_repo/update_job_repo.dart';
import '../../../data_sources/remote/jobs/update_job_remote_data_source/update_job_remote_data_source.dart';
@Injectable(as: UpdateJobRepo)
 class UpdateJobRepoImpl implements UpdateJobRepo {
   final UpdateJobRemoteDataSource remoteDataSource;

   UpdateJobRepoImpl(this.remoteDataSource);

   @override
   Future<Either<Failures, void>> updateJob(JobEntity jobEntity) {
     return remoteDataSource.updateJob(jobEntity);
   }
 }