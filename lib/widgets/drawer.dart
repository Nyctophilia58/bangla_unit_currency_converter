import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/language_provider.dart';
import '../providers/theme_provider.dart';
import '../screens/about_us.dart';
import '../services/iap_service.dart';

class MyDrawer extends StatelessWidget {
  final IAPService iapService;
  const MyDrawer({super.key, required this.iapService});

  Future<bool> _hasRatedApp() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('hasRated') ?? false;
  }

  Future<void> _setRatedApp() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasRated', true);
  }

  @override
  Widget build(BuildContext context) {
    final language = Provider.of<LanguageProvider>(context);

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Material(
      color: Theme.of(context).colorScheme.background,
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
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Theme(
                      data: Theme.of(context).copyWith(
                        dividerColor: Colors.transparent,
                      ),
                      child: ExpansionTile(
                        leading: Icon(
                          Icons.language,
                          size: 26,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                        trailing: const SizedBox.shrink(),
                        title: Text(
                          language.isEnglish ? 'Language' : 'ভাষা',
                          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontSize: 24,
                          ),
                        ),
                        children: [
                          ListTile(
                            contentPadding: const EdgeInsets.only(left: 30),
                            title: Text(
                              language.isEnglish ? 'English' : 'ইংরেজি',
                              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                color: language.isEnglish
                                    ? Colors.green[700]
                                    : Theme.of(context).colorScheme.onBackground,
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
                              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                color: language.isEnglish
                                    ? Theme.of(context).colorScheme.onBackground
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
                    ValueListenableBuilder<bool>(
                      valueListenable: iapService.isProNotifier,
                      builder: (context, isPro, child) {
                        return isPro
                            ? const SizedBox.shrink()
                            : ListTile(
                          leading: Icon(
                            Icons.lock,
                            size: 26,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                          title: Text(
                            language.isEnglish ? 'Unlock Pro' : 'প্রো আনলক করুন',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                              color:
                              Theme.of(context).colorScheme.onBackground,
                              fontSize: 24,
                            ),
                          ),
                          onTap: () async {
                            try {
                              await iapService.purchasePro();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(language.isEnglish
                                      ? 'Processing purchase...'
                                      : 'ক্রয় প্রক্রিয়াকরণ...'),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(language.isEnglish
                                      ? 'Purchase failed: $e'
                                      : 'ক্রয় ব্যর্থ হয়েছে: $e'),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Provider.of<ThemeProvider>(context).isDarkMode
                            ? Icons.dark_mode
                            : Icons.light_mode,
                        size: 26,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      title: Text(
                        language.isEnglish ? 'App Theme' : 'অ্যাপ থিম',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: 24,
                        ),
                      ),
                      trailing: CupertinoSwitch(
                        value: Provider.of<ThemeProvider>(context, listen: false).isDarkMode,
                        onChanged: (value) {
                          Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
                        },
                        inactiveTrackColor: Colors.black38,
                      ),
                    ),
                    FutureBuilder<bool>(
                      future: _hasRatedApp(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const SizedBox.shrink();
                        }
                        final hasRated = snapshot.data ?? false;
                        return hasRated
                            ? const SizedBox.shrink()
                            : ListTile(
                          leading: Icon(
                            Icons.star_rate,
                            size: 26,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                          title: Text(
                            language.isEnglish ? 'Rate Us' : 'রেট করুন',
                            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: Theme.of(context).colorScheme.onBackground,
                              fontSize: 24,
                            ),
                          ),
                          onTap: () async {
                            final InAppReview inAppReview = InAppReview.instance;
                            try {
                              if (await inAppReview.isAvailable()) {
                                await inAppReview.requestReview();
                                await _setRatedApp();
                              } else {
                                final url = Uri.parse(
                                    'https://play.google.com/store/apps/details?id=com.nowshin.unit_currency_converter');
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(url, mode: LaunchMode.externalApplication);
                                  await _setRatedApp();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(language.isEnglish
                                          ? 'Could not open Play Store'
                                          : 'প্লে স্টোর খুলতে পারেনি'),
                                    ),
                                  );
                                }
                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(language.isEnglish
                                      ? 'Error launching review: $e'
                                      : 'রিভিউ চালু করতে ত্রুটি: $e'),
                                ),
                              );
                            }
                          },
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.info_outline_rounded,
                        size: 26,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      title: Text(
                        language.isEnglish ? 'About Us' : 'আমাদের সম্পর্কে',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
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
                    ListTile(
                      leading: Icon(
                        Icons.code_rounded,
                        size: 26,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      title: Text(
                        language.isEnglish ? 'Github' : 'গিটহাব',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: 24,
                        ),
                      ),
                      onTap: () async {
                        final url = Uri.parse(
                            'https://github.com/Nyctophilia58/bangla_unit_currency_converter');
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url, mode: LaunchMode.externalApplication);
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