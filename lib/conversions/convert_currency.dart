import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constant/api_key.dart';

Future<double?> convertCurrency(double amount, String from, String to, {http.Client? client}) async {
  client ??= http.Client();
  final url = 'https://v6.exchangerate-api.com/v6/$apiKey/latest/$from';

  try {
    final response = await client.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final rate = data['conversion_rates'][to];
      return amount * rate;
    } else {
      print('Failed to fetch exchange rate: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error fetching exchange rate: $e');
    return null;
  } finally {
    client.close();
  }
}
