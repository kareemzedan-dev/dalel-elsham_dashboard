import 'package:dart_either/dart_either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../../../../core/errors/failures.dart';
import '../../../../../../../../../../core/helper/network_validation.dart';
import '../../../../../../../../../../core/services/firebase_service.dart';
import '../../../../../domain/entities/job_entity.dart';
import '../../../../data_sources/remote/jobs/update_opportunity_remote_data_source/update_opportunity_remote_data_source.dart';
import '../../../../models/job_model.dart';


@Injectable(as: UpdateOpportunityRemoteDataSource)
class UpdateOpportunityRemoteDataSourceImpl implements UpdateOpportunityRemoteDataSource {
  final FirebaseService firebaseService;

  UpdateOpportunityRemoteDataSourceImpl(this.firebaseService);

  @override
  Future<Either<Failures, void>>updateOpportunity (JobEntity jobEntity) async {
    try {

      if (!await NetworkValidation.hasInternet()) {
        return Left(NetworkFailure("لا يوجد اتصال بالانترنت"));
      }


      final updatedModel = JobModel(
        id: jobEntity.id,
        title: jobEntity.title,
        description: jobEntity.description,
        type: jobEntity.type,
        phone: jobEntity.phone,
        location: jobEntity.location,
        imageUrl: jobEntity.imageUrl,
        isActive: jobEntity.isActive,
        duration: jobEntity.duration,
        createdAt: jobEntity.createdAt,
        status: jobEntity.status,
      );


      await firebaseService.updateDocument(
        collection: "opportunities",
        docId: jobEntity.id,
        data: updatedModel.toMap(),
      );

      return const Right(null);

    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
