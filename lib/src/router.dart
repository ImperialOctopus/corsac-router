part of corsac_router;

/// Basic implementation of a router.
/// T is the type of data mapped to resources.
class Router<T> {
  /// Map of registered [HttpResource]s to user-defined data user wants to
  /// associate with particular resource. The data can be pretty much anything.
  /// Some examples include:
  ///
  /// * [Type] of a controller (for MVC implementations)
  /// * [Function] handler (for simple solutions)
  ///
  /// You can always leave it as `null` if you don't need to associate any
  /// information with your resources.
  final Map<HttpResource, T> resources = <HttpResource, T>{};

  /// Matches [uri] and [httpMethod] to a resource.
  /// Returns null if nothing matches.
  MatchResult<T>? match(Uri uri, String httpMethod, {Map? attributes}) {
    for (final resource in resources.keys) {
      if (resource.matches(uri,
          httpMethod: httpMethod, attributes: attributes)) {
        return MatchResult<T>(resource, resources[resource],
            resource.resolveParameters(uri), resource.attributes);
      } else {}
    }
    return null;
  }
}

/// Result of matching an [Uri] with [Router].
class MatchResult<T> {
  /// Matching HTTP resource.
  final HttpResource resource;

  /// Data associated with the resource.
  final T? data;

  /// Resource parameters extracted from the `Uri`.
  final Map<String, String> parameters;

  /// User-defined custom attributes associated with the resource.
  final Map attributes;

  /// Result of matching an [Uri] with [Router].
  MatchResult(this.resource, this.data, this.parameters, this.attributes);
}
