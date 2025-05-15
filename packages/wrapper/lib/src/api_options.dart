/// Options for connecting to the Epic Hire API.
abstract class ApiOptions {
  /// The default value for the `User-Agent` header.
  static const defaultUserAgent =
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36';

  /// The host at which the API can be found.
  ///
  /// This will always be `api.epichire.com`
  static const defaultHost = 'api.epichire.com';

  /// The base URI relative to the [defaultHost] where the API can be found.
  String get baseUri => '';

  /// The version of the API to use.
  /// EpicHire isn't consistent on which api to use, so we have to do this on a per-req basis.
  // int get apiVersion => 2;

  /// The value of the `Authorization` header to use when authenticating requests.
  String? get authorizationHeader;

  /// The value of the `User-Agent` header to send with each request.
  final String userAgent;

  /// The host at which the API can be found.
  final String host;

  /// The host at which the CDN can be found.
  String get cdnHost => 'https://epic-hire.s3.amazonaws.com/';

  /// Create a new [ApiOptions].
  ApiOptions({this.userAgent = defaultUserAgent, this.host = defaultHost});
}

/// Options for connecting to the Epic Hire API to make HTTP requests with a token.
class RestApiOptions extends ApiOptions {
  /// The token to use.
  final String? token;

  /// User id of the user
  final int? userId;

  @override
  String? get authorizationHeader => token;

  /// Create a new [RestApiOptions].
  RestApiOptions({this.token, this.userId, super.userAgent, super.host});
}
