abstract class RemoveProjectFromSectionStates {}
class RemoveProjectFromSectionLoading extends RemoveProjectFromSectionStates {}
class RemoveProjectFromSectionSuccess extends RemoveProjectFromSectionStates {}
class RemoveProjectFromSectionError extends RemoveProjectFromSectionStates {
  final String message;

  RemoveProjectFromSectionError(this.message);
}
