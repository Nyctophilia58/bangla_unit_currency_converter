import 'package:flutter_test/flutter_test.dart';
import 'package:unit_currency_converter/conversions/convert_weight.dart';

void main() {
  group('Weight Conversion Tests - ', () {
    test('Convert kilograms to pounds', () {
      double result = convertWeight(3, 'Kg', 'Lb');
      expect(result, closeTo(6.61386786, 0.0001));
    });

    test('Convert kilograms to ounces', () {
      double result = convertWeight(3, 'Kg', 'Oz');
      expect(result, closeTo(105.82099, 0.001));
    });

    test('Convert kilograms to stones', () {
      double result = convertWeight(3, 'Kg', 'Stone');
      expect(result, closeTo(0.472779, 0.001));
    });

    test('Convert pounds to kilograms', () {
      double result = convertWeight(3, 'Lb', 'Kg');
      expect(result, closeTo(1.360777, 0.0001));
    });

    test('Convert pounds to ounces', () {
      double result = convertWeight(3, 'Lb', 'Oz');
      expect(result, closeTo(48.0, 0.0001));
    });

    test('Convert pounds to stones', () {
      double result = convertWeight(3, 'Lb', 'Stone');
      expect(result, closeTo(0.2142857142857143, 0.0001));
    });

    test('Convert ounces to kilograms', () {
      double result = convertWeight(3, 'Oz', 'Kg');
      expect(result, closeTo(0.0850486, 0.0001));
    });

    test('Convert ounces to pounds', () {
      double result = convertWeight(3, 'Oz', 'Lb');
      expect(result, closeTo(0.1875, 0.0001));
    });

    test('Convert ounces to stones', () {
      double result = convertWeight(3, 'Oz', 'Stone');
      expect(result, closeTo(0.0133928571428571, 0.0001));
    });

    test('Convert stones to kilograms', () {
      double result = convertWeight(3, 'Stone', 'Kg');
      expect(result, closeTo(19.05, 0.001));
    });

    test('Convert stones to pounds', () {
      double result = convertWeight(3, 'Stone', 'Lb');
      expect(result, closeTo(42.0, 0.0001));
    });

    test('Convert stones to ounces', () {
      double result = convertWeight(3, 'Stone', 'Oz');
      expect(result, closeTo(672.0, 0.001));
    });
  });
}
