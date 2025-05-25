import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import '../providers/theme_provider.dart';


class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

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
                        trailing: SizedBox.shrink(),
                        title: Text(
                          language.isEnglish ? 'Language' : 'ভাষা',
                          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontSize: 24,
                          ),
                        ),
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.only(left: 30),
                            title: Text(
                              language.isEnglish ? 'English' : 'ইংরেজি',
                              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                color: language.isEnglish ? Colors.green[700] : Theme.of(context).colorScheme.onBackground,
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
                            contentPadding: EdgeInsets.only(left: 30),
                            title: Text(
                              language.isEnglish ? 'Bangla' : 'বাংলা',
                              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                color: language.isEnglish ? Theme.of(context).colorScheme.onBackground : Colors.green[700],
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

                    ListTile(
                      // Unlock Pro
                      leading: Icon(
                        Icons.lock,
                        size: 26,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      title: Text(
                        language.isEnglish ? 'Unlock Pro' : 'প্রো আনলক করুন',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: 24,
                        ),
                      ),
                      onTap: () {
                      },
                    ),

                    ListTile(
                      leading: Icon(
                        Provider.of<ThemeProvider>(context).isDarkMode ? Icons.dark_mode : Icons.light_mode,
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
                    ListTile(
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
                      onTap: () {
                        // onSelected('filters');
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
                        // onSelected('filters');
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
                      onTap: () {}
                    )
                  ]
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}