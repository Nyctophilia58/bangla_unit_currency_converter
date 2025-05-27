import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsPage extends StatelessWidget {
  final Uri sourceCodeUrl = Uri.parse('https://github.com/Nyctophilia58/bangla_unit_currency_converter');

  void _launchURL() async {
    if (!await launchUrl(sourceCodeUrl, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $sourceCodeUrl';
    }

  }
  AboutUsPage({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,

      appBar: AppBar(
        title: Text('About'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
            children: [
              TextSpan(text: "This application is made by "),
              TextSpan(text: "NowTechDev", style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: ", a solo endeavour of "),
              TextSpan(text: "Homiya Nowshin Ananna.", style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: "This application is open source. You can find the source code at "),
              TextSpan(
                text: 'github',
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()..onTap = _launchURL,
              ),
              TextSpan(text: '.\n\n'),

              TextSpan(text: "Resources attributed below are used to make this.\n"),
              // Exchange rate api use
              TextSpan(text: " -> Exchange rate data is provided by "),
              TextSpan(
                text: 'ExchangeRate-API',
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()..onTap = () {
                  launchUrl(Uri.parse('https://www.exchangerate-api.com/'));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
