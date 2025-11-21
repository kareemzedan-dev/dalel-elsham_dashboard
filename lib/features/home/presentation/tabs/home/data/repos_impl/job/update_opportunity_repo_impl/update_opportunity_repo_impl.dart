import 'package:dart_either/dart_either.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/domain/entities/job_entity.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../../../core/errors/failures.dart';
import '../../../../domain/repos/job/update_opportunity_repo/update_opportunity_repo.dart';
import '../../../data_sources/remote/jobs/update_opportunity_remote_data_source/update_opportunity_remote_data_source.dart';
@Injectable(as: UpdateOpportunityRepo)
 class UpdateOpportunityRepoImpl implements UpdateOpportunityRepo {
   final UpdateOpportunityRemoteDataSource remoteDataSource;
   UpdateOpportunityRepoImpl(this.remoteDataSource);
  @override
  Future<Either<Failures, void>> updateOpportunity(JobEntity opportunityEntity) {
    return remoteDataSource.updateOpportunity(opportunityEntity);
  }
}