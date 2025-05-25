import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'package:unit_currency_converter/constant/api_key.dart';

// Replace the original function to allow injecting the client
Future<double?> convertCurrencyWithClient(double amount, String from, String to, http.Client client) async {
  final url = 'https://v6.exchangerate-api.com/v6/$apiKey/latest/$from';

  try {
    final response = await client.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final rate = data['conversion_rates'][to];
      return amount * rate;
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

void main() {
  group('Currency Conversion Tests - ', () {
    test('returns converted amount on valid response', () async {
      final client = MockClient((request) async {
        return http.Response(jsonEncode({
          'conversion_rates': {'EUR': 0.9}
        }), 200);
      });

      final result = await convertCurrencyWithClient(100, 'USD', 'EUR', client);
      expect(result, 90.0);
    });

    test('returns null on error response', () async {
      final client = MockClient((request) async {
        return http.Response('Not Found', 404);
      });

      final result = await convertCurrencyWithClient(100, 'USD', 'EUR', client);
      expect(result, isNull);
    });

    test('returns null on exception', () async {
      final client = MockClient((request) async {
        throw Exception('Connection failed');
      });

      final result = await convertCurrencyWithClient(100, 'USD', 'EUR', client);
      expect(result, isNull);
    });
  });
}
