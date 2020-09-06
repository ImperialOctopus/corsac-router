library corsac_router.test.router;

import 'package:test/test.dart';
import 'package:corsac_router/corsac_router.dart';

void main() {
  group('Router', () {
    test('it matches to a route', () {
      final r = HttpResource('/users', ['GET'],
          attributes: <Symbol, String>{#version: '1'});

      final router = Router<String>();
      router.resources[r] = 'test';

      var result = router.match(Uri.parse('/users'), 'GET',
          attributes: <Symbol, String>{#version: '1'});

      expect(result, isA<MatchResult>());
      expect(result, isNotNull);
      result!;
      expect(result.resource, same(r));
      expect(result.data, equals('test'));
      expect(result.parameters, isMap);
      expect(result.parameters, isEmpty);
      expect(result.attributes, isMap);
      expect(result.attributes[#version], equals('1'));
    });

    test('it matches null when no route found', () {
      final r = HttpResource('/users', ['GET']);

      final router = Router<dynamic>();
      router.resources[r] = 'test';

      var result = router.match(Uri.parse('/nope'), 'GET');

      expect(result, isNull);
    });
  });
}
