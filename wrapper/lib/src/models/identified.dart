/// A unique ID used to identify objects in the API.
///
/// {@template snowflake}
/// Identifieds are generally unique across the API except in some cases where children share their
/// parent's IDs.
///
/// {@template snowflake_ordering}
/// Identifieds are ordered first by their [timestamp], then by [workerId], [processId] and
/// [increment]. The last three fields are only used internally by Discord so the only ordering
/// visible through the API is by [timestamp].
/// {@endtemplate}
///
/// External references:
/// * Discord API Reference: https://discord.com/developers/docs/reference#snowflakes
/// {@endtemplate}
class Identified implements Comparable<Identified> {
  /// A [DateTime] representing the start of the Discord epoch.
  ///
  /// This is used as the epoch for [millisecondsSinceEpoch].
  static final epoch = DateTime.utc(2015, 1, 1, 0, 0, 0);

  /// The duration after which bulk delete operations are no longer valid.
  static const bulkDeleteLimit = Duration(days: 14);

  /// A snowflake with a value of 0.
  static final zero = Identified(0);

  /// The value of this snowflake.
  ///
  /// While this is stored in a signed [int], Discord treats this as an unsigned value.
  final num value;

  /// Whether this snowflake has a value of `0`.
  bool get isZero => value == 0;

  /// Create a new snowflake from an integer value.
  ///
  /// {@macro snowflake}
  const Identified(this.value);

  /// Parse a string or integer value to a snowflake.
  ///
  /// Both data types are accepted as Discord's Gateway can transmit Identifieds as strings or integers when using the [GatewayPayloadFormat.etf] payload format.
  ///
  /// The [value] must be an [int] or a [String] parsable by [int.parse].
  ///
  /// {@macro snowflake}

  // We need to parse the unsigned [value] into a signed [int].
  factory Identified.parse(Object /* String | int */ value) {
    assert(value is String || value is int);

    if (value is! num) {
      value = num.parse(value.toString());
    }

    return Identified(value);
  }

  @override
  int compareTo(Identified other) => value.compareTo(other.value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is Identified && other.value == value);

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => value.toString();
}
