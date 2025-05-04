import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import '../providers/theme_provider.dart';
import '../themes/theme_mode.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final language = Provider.of<LanguageProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Icon(
              Icons.currency_exchange,
              size: 100,
              color: Theme.of(context).colorScheme.inversePrimary,
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
                    title: Text('Language', style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 24,
                    ),),
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.only(left: 30),
                        title: Text('English', style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: language.isEnglish ? Colors.green : Colors.black,
                          fontSize: 20,
                        ),),
                        onTap: () {
                          if (!language.isEnglish) {
                            language.setLanguage(true);
                          }
                        },
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.only(left: 30),
                        onTap: () {
                          if (language.isEnglish) {
                            language.setLanguage(false);
                          }
                        },
                        title: Text('Bangla', style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: language.isEnglish ? Colors.black : Colors.green,
                          fontSize: 20,
                        ),),

                      ),
                    ],
                  ),
                ),

                ListTile(
                  leading: Icon(
                    Icons.dark_mode_outlined,
                    size: 26,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  title: Text('Theme', style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 24,
                  ),),
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
                  title: Text('Rate Us', style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 24,
                  ),),
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
                  title: Text('About Us', style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 24,
                  ),),
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
                  title: Text('Github', style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 24,
                  ),),
                  onTap: () {
                    // onSelected('filters');
                  },
                )
              ]
            )
          ),
        ],
      ),
    );
  }
}