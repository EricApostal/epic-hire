/// The base class for all exceptions thrown by Wrapper.
class WrapperException implements Exception {
  /// The message for this exception.
  final String message;

  /// Create a new [WrapperException] with the provided [message].
  WrapperException(this.message);

  @override
  String toString() => message;
}

/// An exception thrown when an unexpected event is received on the Gateway.
class InvalidEventException extends WrapperException {
  /// Create a new [InvalidEventException] with the provided [message].
  InvalidEventException(String message)
    : super('Invalid gateway event: $message');
}

/// An error thrown when an issue with a client's plugin is encountered.
class PluginError extends Error {
  /// The message for this [PluginError].
  final String message;

  /// Create a new [PluginError].
  PluginError(this.message);

  @override
  String toString() => message;
}
