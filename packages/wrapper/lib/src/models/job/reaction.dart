class Reaction {
  final int id;
  final String type;
  final int userId;
  final dynamic mongoObjectId;

  Reaction({
    required this.id,
    required this.type,
    required this.userId,
    this.mongoObjectId,
  });
}
