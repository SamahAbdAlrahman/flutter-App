import 'package:flutter/material.dart';
import 'package:new_flutter_app/readData.dart';
import 'package:new_flutter_app/screens/add_event.dart';
import 'package:new_flutter_app/screens/main_tab.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'core/provider/AppLanguageProvider.dart';
import 'core/provider/AppThemeProvider.dart';
import 'core/utiles/app_theme.dart';





import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(

  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context)=>AppLanguageProvider(),),
      ChangeNotifierProvider(create: (context)=>AppThemeProvider(),),
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
        '/':(context)=>   maintab(),

        // GetUsersPage(),
        // '/login':(context)=>login(),
        // '/addevent':(context)=>AddEventPage(),
      },
   );
  }
}


