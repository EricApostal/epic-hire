/// A member of a [Conversation]
class ConversationMember {
  final int id;
  final ConversationMemberType memberType;
  final int relatedEntityId;
  final String displayName;
  final String imageKey;
  final ConversationMemberRole role;

  ConversationMember({
    required this.id,
    required this.memberType,
    required this.relatedEntityId,
    required this.displayName,
    required this.imageKey,
    required this.role,
  });
}

/// The type of a [ConversationMember].
enum ConversationMemberType {
  admin._('USER'),
  developer._('CLUB'),
  readOnly._('COMPANY');

  /// The value of this [ConversationMemberType].
  final String value;

  const ConversationMemberType._(this.value);

  /// Parse a [ConversationMemberType] from a [String].
  ///
  /// The [value] must be a valid team member role.
  factory ConversationMemberType.parse(String value) =>
      ConversationMemberType.values.firstWhere(
        (memberType) => memberType.value == value,
        orElse: () =>
            throw FormatException('Unknown conversation member type', value),
      );
  @override
  String toString() => 'ConversationMemberType($value)';
}

/// The role of a [ConversationMember].
enum ConversationMemberRole {
  admin._('OWNER'),
  developer._('ADMIN'),
  readOnly._('MEMBER');

  /// The value of this [ConversationMemberType].
  final String value;

  const ConversationMemberRole._(this.value);

  /// Parse a [ConversationMemberRole] from a [String].
  ///
  /// The [value] must be a valid team member role.
  factory ConversationMemberRole.parse(String value) =>
      ConversationMemberRole.values.firstWhere(
        (role) => role.value == value,
        orElse: () => throw FormatException('Unknown conversation role', value),
      );
  @override
  String toString() => 'ConversationMemberRole($value)';
}
