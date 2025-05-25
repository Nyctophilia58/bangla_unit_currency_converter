import 'package:flutter_test/flutter_test.dart';
import 'package:unit_currency_converter/conversions/convert_temperature.dart';

void main() {
  group('Temperature Conversion Tests - ',(){
    test('Convert Celsius to Fahrenheit', () {
      double result = convertTemperature(100, 'Celsius', 'Fahrenheit');
      expect(result, closeTo(212.0, 0.00001));
    });

    test('Convert Celsius to Kelvin', () {
      double result = convertTemperature(100, 'Celsius', 'Kelvin');
      expect(result, closeTo(373.15, 0.00001));
    });

    test('Convert Fahrenheit to Celsius', () {
      double result = convertTemperature(212, 'Fahrenheit', 'Celsius');
      expect(result, closeTo(100.0, 0.00001));
    });

    test('Convert Fahrenheit to Kelvin', () {
      double result = convertTemperature(212, 'Fahrenheit', 'Kelvin');
      expect(result, closeTo(373.15, 0.00001));
    });

    test('Convert Kelvin to Celsius', () {
      double result = convertTemperature(373.15, 'Kelvin', 'Celsius');
      expect(result, closeTo(100.0, 0.00001));
    });

    test('Convert Kelvin to Fahrenheit', () {
      double result = convertTemperature(373.15, 'Kelvin', 'Fahrenheit');
      expect(result, closeTo(212.0, 0.00001));
    });
  });
}