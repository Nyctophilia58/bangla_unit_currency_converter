import 'package:flutter_test/flutter_test.dart';
import 'package:unit_currency_converter/conversions/convert_height.dart';

void main() {
  group('Height Conversion Tests - ', ()
  {
    test('Convert Feet to Meters', () {
      double result = convertHeight(3, 'Feet', 'Meters');
      expect(result, closeTo(0.9144, 0.00001));
    });

    test('Convert Feet to Inches', () {
      double result  = convertHeight(3, 'Feet', 'Inches');
      expect(result, closeTo(36.0, 0.00001));
    });

    test('Convert Feet to Centimeters', () {
      double result = convertHeight(3, 'Feet', 'Centimeters');
      expect(result, closeTo(91.44, 0.00001));
    });

    test('Convert Meters to Feet', () {
      double result = convertHeight(3, 'Meters', 'Feet');
      expect(result, closeTo(9.84252, 0.00001));
    });

    test('Convert Meters to Inches', () {
      double result = convertHeight(3, 'Meters', 'Inches');
      expect(result, closeTo(118.110236, 0.00001));
    });

    test('Convert Meters to Centimeters', () {
      double result = convertHeight(3, 'Meters', 'Centimeters');
      expect(result, closeTo(300.0, 0.00001));
    });

    test('Convert Inches to Feet', () {
      double result = convertHeight(3, 'Inches', 'Feet');
      expect(result, closeTo(0.25, 0.00001));
    });

    test('Convert Inches to Meters', () {
      double result = convertHeight(3, 'Inches', 'Meters');
      expect(result, closeTo(0.0762, 0.00001));
    });

    test('Convert Inches to Centimeters', () {
      double result = convertHeight(3, 'Inches', 'Centimeters');
      expect(result, closeTo(7.62, 0.00001));
    });

    test('Convert Centimeters to Feet', () {
      double result = convertHeight(3, 'Centimeters', 'Feet');
      expect(result, closeTo(0.0984252, 0.00001));
    });

    test('Convert Centimeters to Meters', () {
      double result = convertHeight(3, 'Centimeters', 'Meters');
      expect(result, closeTo(0.03, 0.00001));
    });

    test('Convert Centimeters to Inches', () {
      double result = convertHeight(3, 'Centimeters', 'Inches');
      expect(result, closeTo(1.18110236, 0.00001));
    });
  });
}
