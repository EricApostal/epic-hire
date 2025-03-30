/// Options for connecting to the Discord API.
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

/// Options for connecting to the Discord API to make HTTP requests with a bot token.
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

/// Options for connecting to the Discord API for making HTTP requests and connecting to the Gateway
/// with a bot token.
class GatewayApiOptions extends RestApiOptions {
  /// The format of the Gateway payloads.
  final GatewayPayloadFormat payloadFormat;

  /// The compression to use on the Gateway connection.
  final GatewayCompression compression;

  /// The threshold after which guilds are considered large in the Gateway.
  final int? largeThreshold;

  /// The query parameters to append to the Gateway connection URL.
  Map<String, String> get gatewayConnectionOptions => {
    // 'v': apiVersion.toString(),
    // 'encoding': payloadFormat.value,
    // if (compression == GatewayCompression.transport)
    //   'compress': 'zlib-stream',
  };

  /// Create a new [GatewayApiOptions].
  GatewayApiOptions({
    required super.token,
    required super.userId,
    super.userAgent,
    super.host,
    this.payloadFormat = GatewayPayloadFormat.json,
    this.compression = GatewayCompression.transport,
    this.largeThreshold,
  });
}

/// The format of Gateway payloads.
enum GatewayPayloadFormat {
  /// Payloads are sent as JSON.
  json._('json'),

  /// Payloads are sent as ETF.
  etf._('etf');

  /// The value of this [GatewayPayloadFormat].
  final String value;

  const GatewayPayloadFormat._(this.value);

  @override
  String toString() => value;
}

/// The compression of a Gateway connection.
enum GatewayCompression {
  /// No compression is used.
  none,

  /// The entire connection is compressed.
  transport,

  /// Each packet is individually compressed.
  ///
  /// Cannot be used if [GatewayPayloadFormat.etf] is used.
  payload,
}
