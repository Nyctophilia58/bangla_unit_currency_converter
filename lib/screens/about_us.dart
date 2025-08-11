import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsPage extends StatelessWidget {
  final Uri sourceCodeUrl = Uri.parse('https://github.com/Nyctophilia58/bangla_unit_currency_converter');

  AboutUsPage({super.key});

  Future<void> _launchURL(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        title: const Text('About'),
        backgroundColor: theme.colorScheme.primary,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // App Info
          Card(
            elevation: 2,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Bangla Unit & Currency Converter",
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "This application is developed by NowTechDev, "
                        "a solo endeavour of Homiya Nowshin Ananna.",
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Source Code Section
          Card(
            elevation: 2,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: const Icon(Icons.code, color: Colors.blueAccent),
              title: const Text("View Source Code on GitHub"),
              subtitle: const Text("This application is open source."),
              trailing: const Icon(Icons.open_in_new, size: 20),
              onTap: () => _launchURL(sourceCodeUrl),
            ),
          ),

          const SizedBox(height: 16),

          // Resources
          Card(
            elevation: 2,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: const Icon(Icons.public, color: Colors.green),
              title: const Text("Exchange Rate Data Provider"),
              subtitle: const Text("ExchangeRate-API"),
              trailing: const Icon(Icons.open_in_new, size: 20),
              onTap: () => _launchURL(
                Uri.parse('https://www.exchangerate-api.com/'),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Footer
          Center(
            child: Text(
              "© ${DateTime.now().year} NowTechDev",
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onBackground.withOpacity(0.6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
