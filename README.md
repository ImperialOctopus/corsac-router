# Corsac Dart HTTP routing library (2.10.0 Null Safety)

[![License](https://img.shields.io/badge/license-BSD--2-blue.svg?style=flat-square)](https://raw.githubusercontent.com/corsac-dart/router/master/LICENSE)

Simple HTTP routing library for server-side applications.

Modified from Anatoly Pulyaevskiy's [Corsac Dart router](https://github.com/corsac-dart/router). Updates to support 2.10.0's non-nullable types and makes the router class generic to enforce type safety on the router resources.

## Installation

There is no Pub package yet so you have to use git dependency for now:

```yaml
dependencies:
  corsac_router:
    git: https://github.com/ImperialOctopus/router.git
```

## Usage

```dart
import 'package:corsac_router/corsac_router.dart';

// First define some `HttpResource`s and register with the `Router`.
final router = Router<String>();
router.resources[HttpResource('/users', ['GET'])] = 'string';
router.resources[HttpResource('/users/{userId}', ['GET'])] = 'other string';

// Then in your HttpServer you can use it to match against incoming HTTP
// requests.

final server = await HttpServer.bind(InternetAddress.LOOPBACK_IP_V4, 8080);
await for (final request in server) {
  final result = router.match(request.uri, request.method);
  if (result != null) {
    // access matched resource and other data via returned result
    // ...
  } else {
    request.response.statusCode = 404;
  }
  request.response.close();
}
```

## License

BSD-2
