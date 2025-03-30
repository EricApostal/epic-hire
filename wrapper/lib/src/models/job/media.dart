class JobMedia {
  final int id;
  final String mediaKey;
  final dynamic caption;
  final int position;

  JobMedia({
    required this.id,
    required this.mediaKey,
    this.caption,
    required this.position,
  });
}
