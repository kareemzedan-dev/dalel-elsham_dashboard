enum RequestType { job, opportunity }
RequestType requestTypeFromString(String? type) {
  switch (type) {
    case "job":
      return RequestType.job;
    case "opportunity":
      return RequestType.opportunity;
    default:
      return RequestType.job; // Default
  }
}