abstract class DeleteBannerViewModelStates {}


class DeleteBannerViewModelStatesInitial extends DeleteBannerViewModelStates {}

class DeleteBannerViewModelStatesLoading extends DeleteBannerViewModelStates {}

class DeleteBannerViewModelStatesSuccess extends DeleteBannerViewModelStates {}

class DeleteBannerViewModelStatesError extends DeleteBannerViewModelStates {
  final String message;

  DeleteBannerViewModelStatesError(this.message);
}
