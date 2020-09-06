library corsac_router.test.resource;

import 'package:test/test.dart';
import 'package:corsac_router/corsac_router.dart';

void main() {
  group('Resource', () {
    test('it matches static route', () {
      final r = HttpResource('/users', ['GET']);
      expect(r.matches(Uri.parse('/users'), httpMethod: 'GET'), isTrue);
      expect(r.matches(Uri.parse('/users'), httpMethod: 'get'), isTrue);
      expect(r.matches(Uri.parse('/users'), httpMethod: 'POST'), isFalse);
      expect(r.matches(Uri.parse('/users?status=active'), httpMethod: 'GET'),
          isTrue);
      expect(r.matches(Uri.parse('/users/'), httpMethod: 'GET'), isFalse);
      expect(r.matches(Uri.parse('/users/1'), httpMethod: 'GET'), isFalse);
    });

    test('it matches only route without HTTP method', () {
      final r = HttpResource('/users', ['GET']);
      expect(r.matches(Uri.parse('/users')), isTrue);
    });

    test('it matches route with parameter', () {
      final r = HttpResource('/users/{userId}', ['GET']);
      expect(r.matches(Uri.parse('/users/234'), httpMethod: 'GET'), isTrue);
      expect(
          r.matches(Uri.parse('/users/324?status=active'), httpMethod: 'GET'),
          isTrue);
      expect(r.matches(Uri.parse('/users/'), httpMethod: 'GET'), isFalse);
      expect(r.matches(Uri.parse('/users/123/'), httpMethod: 'GET'), isFalse);
      expect(
          r.matches(Uri.parse('/users/123/baz'), httpMethod: 'GET'), isFalse);
    });

    test('it extracts route parameters', () {
      final r = HttpResource('/users/{userId}', ['GET']);
      final params = r.resolveParameters(Uri.parse('/users/234'));
      expect(params, isMap);
      expect(params, hasLength(equals(1)));
      expect(params['userId'], equals('234'));
    });

    test('it matches only when attributes match', () {
      final r = HttpResource('/users', ['GET'],
          attributes: <Symbol, String>{#version: '1'});
      expect(r.matches(Uri.parse('/users')), isFalse);
      expect(
          r.matches(Uri.parse('/users'),
              attributes: <Symbol, int>{#version: 1}),
          isFalse);
      expect(
          r.matches(Uri.parse('/users'),
              attributes: <Symbol, String>{#version: '1'}),
          isTrue);
    });

    test('equality', () {
      var r1 = HttpResource('/users', ['GET'],
          attributes: <Symbol, String>{#version: '1'});
      var r2 = HttpResource('/users', ['GET'],
          attributes: <Symbol, String>{#version: '1'});
      var r3 = HttpResource('/users', ['GET']);
      var r4 = HttpResource('/users', ['GET'],
          attributes: <Symbol, String>{#version: '2'});
      var r5 = HttpResource('/users', ['GET'],
          attributes: <Symbol, String>{#otherke: '1'});
      var r6 = HttpResource('/users', ['PUT'],
          attributes: <Symbol, String>{#version: '1'});
      var r7 = HttpResource('/posts', ['GET'],
          attributes: <Symbol, String>{#version: '1'});
      var r8 = HttpResource('/users', ['get'],
          attributes: <Symbol, String>{#version: '1'});

      expect(r1, equals(r2));
      expect(r1, isNot(equals(r3)));
      expect(r1, isNot(equals(r4)));
      expect(r1, isNot(equals(r5)));
      expect(r1, isNot(equals(r6)));
      expect(r1, isNot(equals(r7)));
      expect(r1, equals(r8));
    });
  });
}
