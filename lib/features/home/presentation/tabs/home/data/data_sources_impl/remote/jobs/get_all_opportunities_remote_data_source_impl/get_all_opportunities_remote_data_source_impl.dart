import 'package:dart_either/dart_either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../../../../core/errors/failures.dart';
import '../../../../../../../../../../core/helper/network_validation.dart';
import '../../../../../../../../../../core/services/firebase_service.dart';
import '../../../../../domain/entities/job_entity.dart';
import '../../../../data_sources/remote/jobs/get_all_opportunities_remote_data_source/get_all_opportunities_remote_data_source.dart';
import '../../../../models/job_model.dart';

@Injectable(as: GetAllOpportunitiesRemoteDataSource)
class GetAllOpportunitiesRemoteDataSourceImpl
    implements GetAllOpportunitiesRemoteDataSource {
  final FirebaseService firebaseService;

  GetAllOpportunitiesRemoteDataSourceImpl(this.firebaseService);

  // ----------------------------------------------------------------
  // 🔵 1) جلب كل الفرص بدون فلترة
  // ----------------------------------------------------------------
  @override
  Future<Either<Failures, List<JobEntity>>> getAllOpportunities() async {
    try {
      if (!await NetworkValidation.hasInternet()) {
        return Left(NetworkFailure("لا يوجد اتصال بالإنترنت"));
      }

      final data = await firebaseService.getCollection(
        collection: "opportunities",
      );

      print("RAW OPPORTUNITIES DATA: $data");

      final opportunities = data
          .map((item) => JobModel.fromMap(item, item["id"]))
          .toList();

      return Right(opportunities);

    } catch (e) {
      return Left(ServerFailure("Error: $e"));
    }
  }

  // ----------------------------------------------------------------
  // 🔵 2) جلب فرص *pending* فقط
  // ----------------------------------------------------------------
  @override
  Future<Either<Failures, List<JobEntity>>> getPendingOpportunities() async {
    try {
      if (!await NetworkValidation.hasInternet()) {
        return Left(NetworkFailure("لا يوجد اتصال بالإنترنت"));
      }

      final data = await firebaseService.getCollection(
        collection: "opportunities",
      );

      print("RAW OPPORTUNITIES DATA: $data");

      final filtered = data.where((item) {
        final status = (item["status"] ?? "").toString().toLowerCase().trim();
        return status == "pending";
      }).toList();

      print("FILTERED OPPORTUNITIES (pending): $filtered");

      final opportunities = filtered
          .map((item) => JobModel.fromMap(item, item["id"]))
          .toList();

      return Right(opportunities);

    } catch (e) {
      return Left(ServerFailure("Error: $e"));
    }
  }
}
