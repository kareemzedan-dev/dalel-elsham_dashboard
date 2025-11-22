abstract class AddBannerViewModelStates {}


class AddBannerViewModelStatesInitial extends AddBannerViewModelStates {}

class AddBannerViewModelStatesLoading extends AddBannerViewModelStates {}

class AddBannerViewModelStatesSuccess extends AddBannerViewModelStates {}

class AddBannerViewModelStatesError extends AddBannerViewModelStates {
  final String message;

  AddBannerViewModelStatesError(this.message);
}