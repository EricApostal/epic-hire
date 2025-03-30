class Media {
  final int id;
  final String mediaKey;
  final dynamic caption;
  final int position;

  Media({
    required this.id,
    required this.mediaKey,
    this.caption,
    required this.position,
  });
}
