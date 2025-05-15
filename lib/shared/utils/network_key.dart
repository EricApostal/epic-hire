String getUrlFromImageKey(String imageKey, {int? width}) {
  if (width == null) {
    return "https://epic-hire.s3.amazonaws.com/$imageKey";
  }
  return "https://app.epichire.com/_next/image?url=https://epic-hire.s3.amazonaws.com/$imageKey&w=${width.toString()}";
}
