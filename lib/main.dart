import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:unit_currency_converter/providers/language_provider.dart';
import 'package:unit_currency_converter/providers/selection_provider.dart';
import 'package:unit_currency_converter/providers/theme_provider.dart';
import 'package:unit_currency_converter/services/iap_service.dart';
import 'screens/converter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const isTest = bool.fromEnvironment('FLUTTER_TEST');
  if (!isTest) {
    await MobileAds.instance.initialize();
  }

  final iapService = IAPService();
  await iapService.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => SelectionProvider()),
        Provider<IAPService>.value(value: iapService),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bangla Unit Currency Converter',
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const ConverterPage(),
    );
  }
}
