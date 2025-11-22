import 'package:dart_either/dart_either.dart';
import 'package:dlyl_alsham_dashboard/features/home/presentation/tabs/home/domain/use_cases/banner_use_case/banner_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../../../core/errors/failures.dart';
import 'delete_banner_view_model_states.dart';
@injectable
class DeleteBannerViewModel extends Cubit<DeleteBannerViewModelStates> {
  final BannerUseCase bannerUseCase;

  DeleteBannerViewModel(this.bannerUseCase)
    : super(DeleteBannerViewModelStatesInitial());

  Future<Either<Failures, void>> deleteBanner(String id) async {
    try {
      emit(DeleteBannerViewModelStatesLoading());
      final result = await bannerUseCase.deleteBanner(id);
      result.fold(
        ifLeft: (fail) => emit(DeleteBannerViewModelStatesError(fail.message)),
        ifRight: (value) => emit(DeleteBannerViewModelStatesSuccess()),
      );
      return result;
    } catch (e) {
      emit(DeleteBannerViewModelStatesError(e.toString()));
      return Left(ServerFailure(e.toString()));
    }
  }
}
