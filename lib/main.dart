import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:record_app/config/AppRoutes.dart';
import 'package:record_app/config/AppProvider.dart';
import 'package:record_app/config/AppTheme.dart';
import 'package:record_app/firebase_options.dart';
import 'package:record_app/image_splash.dart';
import 'package:record_app/providers/ThemeProvider.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:provider/provider.dart';
import 'config/Applocalizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GlobalConfiguration().loadFromAsset("config");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: providers(),
        child: Consumer<ThemeProvider>(
          builder: (context, value, child) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Khaire',
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              routes: AppRoutes().routes(),
              home: ImageSplash(),

              themeMode: value.darkMode ? ThemeMode.dark : ThemeMode.light,
              // List all of the app's supported locales here
              supportedLocales: [
                Locale('en', 'US'),
                Locale('sk', 'SK'),
              ],
              // These delegates make sure that the localization data for the proper language is loaded
              localizationsDelegates: [
                // A class which loads the translations from JSON files
                AppLocalizations.delegate,
                // Built-in localization of basic text for Material widgets
                GlobalMaterialLocalizations.delegate,
                // Built-in localization for text direction LTR/RTL
                GlobalWidgetsLocalizations.delegate,
              ],
              // Returns a locale which will be used by the app
              localeResolutionCallback: (locale, supportedLocales) =>
                  AppLocalizations(locale)
                      .localeResolutionCallback(supportedLocales),
            );
          },
        ));
  }
}
