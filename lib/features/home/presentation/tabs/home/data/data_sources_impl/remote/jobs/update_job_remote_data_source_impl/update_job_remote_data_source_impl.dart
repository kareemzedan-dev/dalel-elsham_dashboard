import 'package:dart_either/dart_either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../../../../core/errors/failures.dart';
import '../../../../../../../../../../core/helper/network_validation.dart';
import '../../../../../../../../../../core/services/firebase_service.dart';
import '../../../../../domain/entities/job_entity.dart';
import '../../../../data_sources/remote/jobs/update_job_remote_data_source/update_job_remote_data_source.dart';

import 'package:dart_either/dart_either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../../../../core/errors/failures.dart';
import '../../../../../../../../../../core/helper/network_validation.dart';
import '../../../../../../../../../../core/services/firebase_service.dart';
import '../../../../../domain/entities/job_entity.dart';
import '../../../../data_sources/remote/jobs/update_job_remote_data_source/update_job_remote_data_source.dart';
import '../../../../models/job_model.dart';

@Injectable(as: UpdateJobRemoteDataSource)
class UpdateJobRemoteDataSourceImpl implements UpdateJobRemoteDataSource {
  final FirebaseService firebaseService;

  UpdateJobRemoteDataSourceImpl(this.firebaseService);

  @override
  Future<Either<Failures, void>> updateJob(JobEntity jobEntity) async {
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
        collection: "jobs",
        docId: jobEntity.id,
        data: updatedModel.toMap(),
      );

      return const Right(null);

    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
