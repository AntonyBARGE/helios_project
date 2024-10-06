// This is an example unit test.
//
// A unit test tests a single function, method, or class. To learn more about
// writing unit tests, visit
// https://flutter.dev/to/unit-testing

import 'package:flutter_test/flutter_test.dart';
import 'package:helios_project/algo.dart';

void main() {
  group('Plus Operator', () {
    test('should add two numbers together', () {
      expect(1 + 1, 2);
    });
  });

  group('XspeedIt Packing Algorithm', () {
    test('Optimized packing should use 8 cartons', () {
      String articles = "163841689525773";
      String packedCartons = packArticles(articles);
      expect(packedCartons.split('/').length, equals(8));
    });
  });
}
