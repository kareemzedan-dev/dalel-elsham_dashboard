import 'package:dart_either/dart_either.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/domain/use_cases/banner_use_case/banner_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../../../core/errors/failures.dart';
import '../../../../domain/entities/banner_entity.dart';
import 'add_banner_view_model_states.dart';
@injectable
class AddBannerViewModel extends Cubit<AddBannerViewModelStates> {
  final BannerUseCase bannerUseCase;

  AddBannerViewModel(this.bannerUseCase)
    : super(AddBannerViewModelStatesInitial());

  Future<Either<Failures, void>> addBanner(BannerEntity banner) async {
    try {
      emit(AddBannerViewModelStatesLoading());
      final result = await bannerUseCase.addBanner(banner);

      result.fold(
        ifLeft: (fail) => emit(AddBannerViewModelStatesError(fail.message)),
        ifRight: (succuss) => emit(AddBannerViewModelStatesSuccess()),
      );
      return result;
    } catch (e) {
      emit(AddBannerViewModelStatesError(e.toString()));
      return Left(ServerFailure(e.toString()));
    }
  }
}
