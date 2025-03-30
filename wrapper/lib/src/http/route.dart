import 'dart:collection';

/// A route within the EpicHire API.
class HttpRoute {
  final List<HttpRoutePart> _parts = [];

  /// The [HttpRoutePart]s that make up this route.
  List<HttpRoutePart> get parts => UnmodifiableListView(_parts);

  /// The segments of this route.
  ///
  /// This includes the names and parameters of this [parts].
  Iterable<String> get segments => parts.expand((part) => part.segments);

  /// The path this [HttpRoute] represents, relative to Discord's root API URL.
  String get path => '/${segments.join('/')}';

  /// An id used for rate limiting.
  ///
  /// Requests wit the same [HttpRoute.rateLimitId] are put in the same [HttpBucket] for
  /// ratelimiting.
  String get rateLimitId => parts
      .expand(
        (part) => [
          part.name,
          ...part.params.map(
            (param) => param.isMajor ? param.value : r'$param',
          ),
        ],
      )
      .join('/');

  /// Add [part] to this route.
  void add(HttpRoutePart part) => _parts.add(part);

  @override
  String toString() => path;
}

/// A part of a [HttpRoute].
///
/// {@template http_route_part}
/// HTTP route parts are made up of an identifier (such as `/users`) and, optionally, one or more
/// parameters (such as the id of a user).
/// {@endtemplate}
class HttpRoutePart {
  /// The name of this part.
  final String name;

  /// The parameters of this part.
  final List<HttpRouteParam> params;

  /// The segments of this part.
  ///
  /// This includes this part's name and parameter values.
  List<String> get segments => [name, ...params.map((param) => param.value)];

  /// Create a new [HttpRoutePart].
  ///
  /// {@macro http_route_part}
  HttpRoutePart(this.name, [this.params = const []]);
}

/// A parameter in a [HttpRoutePart].
class HttpRouteParam {
  /// The value of this parameter.
  final String value;

  /// Whether this parameter is a major parameter.
  ///
  /// Major parameters will be included in the [HttpRoute.rateLimitId], so requests to the same
  /// endpoint but different major parameters will be in separate rate limit buckets.
  final bool isMajor;

  /// Create a new [HttpRouteParam].
  ///
  /// {@macro http_route_param}
  HttpRouteParam(this.value, {this.isMajor = false});
}

/// Helper methods for constructing [HttpRoute]s.
extension RouteHelpers on HttpRoute {
  void users({String? id}) =>
      add(HttpRoutePart("users", [if (id != null) HttpRouteParam(id)]));

  void public() => add(HttpRoutePart("public"));
  void companyPages() => add(HttpRoutePart("company-pages"));
  void clubs() => add(HttpRoutePart("clubs"));
  void search() => add(HttpRoutePart("search"));
}
