import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/language_provider.dart';
import '../providers/theme_provider.dart';
import '../screens/about_us.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final InAppReview _inAppReview = InAppReview.instance;
  bool _hasRated = false;

  @override
  void initState() {
    super.initState();
    _loadRateStatus();
  }

  Future<void> _loadRateStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _hasRated = prefs.getBool('hasRated') ?? false;
    });
  }

  Future<void> _handleRateUs() async {
    try {
      if (await _inAppReview.isAvailable()) {
        await _inAppReview.requestReview();

        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('hasRated', true);

        setState(() {
          _hasRated = true;
        });
      } else {
        final url = Uri.parse(
          'https://play.google.com/store/apps/details?id=com.nowshin.unit_currency_converter',
        );
        if (await canLaunchUrl(url)) {
          await launchUrl(url, mode: LaunchMode.externalApplication);
        }
      }
    } catch (e) {
      debugPrint("Error showing in-app review: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final language = Provider.of<LanguageProvider>(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Material(
      color: theme.colorScheme.background,
      child: SizedBox(
        width: screenWidth,
        height: screenHeight,
        child: SafeArea(
          child: Column(
            children: [
              DrawerHeader(
                child: Image.asset(
                  'assets/icons/transformation.png',
                  height: 100,
                  width: 100,
                  color: theme.colorScheme.onBackground,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    // Language settings
                    Theme(
                      data: theme.copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        leading: Icon(
                          Icons.language,
                          size: 26,
                          color: theme.colorScheme.onBackground,
                        ),
                        trailing: const SizedBox.shrink(),
                        title: Text(
                          language.isEnglish ? 'Language' : 'ভাষা',
                          style: theme.textTheme.titleSmall!.copyWith(
                            color: theme.colorScheme.onBackground,
                            fontSize: 24,
                          ),
                        ),
                        children: [
                          ListTile(
                            contentPadding: const EdgeInsets.only(left: 30),
                            title: Text(
                              language.isEnglish ? 'English' : 'ইংরেজি',
                              style: theme.textTheme.titleSmall!.copyWith(
                                color: language.isEnglish
                                    ? Colors.green[700]
                                    : theme.colorScheme.onBackground,
                                fontSize: 20,
                              ),
                            ),
                            onTap: () {
                              if (!language.isEnglish) {
                                language.setLanguage(true);
                              }
                            },
                          ),
                          ListTile(
                            contentPadding: const EdgeInsets.only(left: 30),
                            title: Text(
                              language.isEnglish ? 'Bangla' : 'বাংলা',
                              style: theme.textTheme.titleSmall!.copyWith(
                                color: language.isEnglish
                                    ? theme.colorScheme.onBackground
                                    : Colors.green[700],
                                fontSize: 20,
                              ),
                            ),
                            onTap: () {
                              if (language.isEnglish) {
                                language.setLanguage(false);
                              }
                            },
                          ),
                        ],
                      ),
                    ),

                    // Theme toggle
                    ListTile(
                      leading: Icon(
                        Provider.of<ThemeProvider>(context).isDarkMode
                            ? Icons.dark_mode
                            : Icons.light_mode,
                        size: 26,
                        color: theme.colorScheme.onBackground,
                      ),
                      title: Text(
                        language.isEnglish ? 'App Theme' : 'অ্যাপ থিম',
                        style: theme.textTheme.titleSmall!.copyWith(
                          color: theme.colorScheme.onBackground,
                          fontSize: 24,
                        ),
                      ),
                      trailing: CupertinoSwitch(
                        value: Provider.of<ThemeProvider>(context,
                            listen: false)
                            .isDarkMode,
                        onChanged: (value) {
                          Provider.of<ThemeProvider>(context, listen: false)
                              .toggleTheme();
                        },
                        inactiveTrackColor: Colors.black38,
                      ),
                    ),

                    // Rate Us
                    if (!_hasRated)
                      ListTile(
                        leading: Icon(
                          Icons.star_rate,
                          size: 26,
                          color: theme.colorScheme.onBackground,
                        ),
                        title: Text(
                          language.isEnglish ? 'Rate Us' : 'রেট করুন',
                          style: theme.textTheme.titleSmall!.copyWith(
                            color: theme.colorScheme.onBackground,
                            fontSize: 24,
                          ),
                        ),
                        onTap: _handleRateUs,
                      ),

                    // About Us
                    ListTile(
                      leading: Icon(
                        Icons.info_outline_rounded,
                        size: 26,
                        color: theme.colorScheme.onBackground,
                      ),
                      title: Text(
                        language.isEnglish
                            ? 'About Us'
                            : 'আমাদের সম্পর্কে',
                        style: theme.textTheme.titleSmall!.copyWith(
                          color: theme.colorScheme.onBackground,
                          fontSize: 24,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AboutUsPage(),
                          ),
                        );
                      },
                    ),

                    // GitHub
                    ListTile(
                      leading: Icon(
                        Icons.code_rounded,
                        size: 26,
                        color: theme.colorScheme.onBackground,
                      ),
                      title: Text(
                        language.isEnglish ? 'Github' : 'গিটহাব',
                        style: theme.textTheme.titleSmall!.copyWith(
                          color: theme.colorScheme.onBackground,
                          fontSize: 24,
                        ),
                      ),
                      onTap: () async {
                        final url = Uri.parse(
                            'https://github.com/Nyctophilia58/bangla_unit_currency_converter');
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url,
                              mode: LaunchMode.externalApplication);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(language.isEnglish
                                  ? 'Could not launch URL'
                                  : 'URL চালু করা যায়নি'),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
