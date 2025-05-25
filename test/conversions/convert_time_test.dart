import 'package:flutter_test/flutter_test.dart';
import 'package:unit_currency_converter/conversions/convert_time.dart';

void main() {
  group('Time Conversion Tests - ', () {
    test('Convert Seconds to Minutes', () {
      double result = convertTime(120, 'Seconds', 'Minutes');
      expect(result, closeTo(2.0, 0.00001));
    });

    test('Convert Seconds to Hours', () {
      double result = convertTime(7200, 'Seconds', 'Hours');
      expect(result, closeTo(2.0, 0.00001));
    });

    test('Convert Seconds to Days', () {
      double result = convertTime(86400, 'Seconds', 'Days');
      expect(result, closeTo(1.0, 0.00001));
    });

    test('Convert Minutes to Seconds', () {
      double result = convertTime(2, 'Minutes', 'Seconds');
      expect(result, closeTo(120.0, 0.00001));
    });

    test('Convert Minutes to Hours', () {
      double result = convertTime(120, 'Minutes', 'Hours');
      expect(result, closeTo(2.0, 0.00001));
    });

    test('Convert Minutes to Days', () {
      double result = convertTime(2880, 'Minutes', 'Days');
      expect(result, closeTo(2.0, 0.00001));
    });

    test('Convert Hours to Seconds', () {
      double result = convertTime(2, 'Hours', 'Seconds');
      expect(result, closeTo(7200.0, 0.00001));
    });

    test('Convert Hours to Minutes', () {
      double result = convertTime(2, 'Hours', 'Minutes');
      expect(result, closeTo(120.0, 0.00001));
    });

    test('Convert Hours to Days', () {
      double result = convertTime(48, 'Hours', 'Days');
      expect(result, closeTo(2.0, 0.00001));
    });

    test('Convert Days to Seconds', () {
      double result = convertTime(1, 'Days', 'Seconds');
      expect(result, closeTo(86400.0, 0.00001));
    });

    test('Convert Days to Minutes', () {
      double result = convertTime(2, 'Days', 'Minutes');
      expect(result, closeTo(2880.0, 0.00001));
    });

    test('Convert Days to Hours', () {
      double result = convertTime(2, 'Days', 'Hours');
      expect(result, closeTo(48.0, 0.00001));
    });
  });
}