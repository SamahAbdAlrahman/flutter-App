import 'package:flutter/material.dart';
import 'package:new_flutter_app/screens/main_tab.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'core/data/event_provider.dart';
import 'core/provider/AppLanguageProvider.dart';
import 'core/provider/AppThemeProvider.dart';
import 'core/provider/event_provider.dart';
import 'core/utiles/app_theme.dart';
void main() {

  runApp(

  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context)=>AppLanguageProvider(),),
      ChangeNotifierProvider(create: (context)=>AppThemeProvider(),),
      ChangeNotifierProvider(create: (context) => EventProvider()),
    ],
    child: MyApp(),

  ));

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(languageProvider.appLanguage),

      themeMode: themeProvider.appTheme,

      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      initialRoute: '/',
      routes: {
        '/':(context)=>maintab(),
      },
   );
  }
}

