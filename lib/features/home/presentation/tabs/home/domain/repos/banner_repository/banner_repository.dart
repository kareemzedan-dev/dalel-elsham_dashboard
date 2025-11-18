import 'package:dart_either/dart_either.dart';

import '../../../../../../../../core/errors/failures.dart';
import '../../entities/banner_entity.dart';

abstract class BannersRepository  {
  Future<Either<Failures, List<BannerEntity>>> getBannersByPosition(String position);
}
