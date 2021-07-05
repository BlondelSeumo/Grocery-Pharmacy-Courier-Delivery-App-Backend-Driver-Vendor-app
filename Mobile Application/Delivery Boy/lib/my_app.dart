import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_theme.dart';
import 'package:fuodz/services/app.service.dart';
import 'package:fuodz/views/pages/splash.page.dart';
import 'package:fuodz/services/auth.service.dart';
import 'constants/app_strings.dart';
import 'package:fuodz/services/router.service.dart' as router;

import 'package:i18n_extension/i18n_widget.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    return AdaptiveTheme(
      light: AppTheme().lightTheme(),
      dark: AppTheme().darkTheme(),
      initial: AdaptiveThemeMode.system,
      builder: (theme, darkTheme) {
        return MaterialApp(
          navigatorKey: AppService.navigatorKey,
          debugShowCheckedModeBanner: false,
          title: AppStrings.appName,
          onGenerateRoute: router.generateRoute,
          // initialRoute: _startRoute,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('en'),
            const Locale('fr'),
            const Locale('es'),
            const Locale('de'),
            const Locale('pt'),
            const Locale('ar'),
            const Locale('ko'),
          ],
          home: I18n(
            child: SplashPage(),
            initialLocale: Locale(AuthServices.getLocale()),
          ),
          theme: theme,
          darkTheme: darkTheme,
        );
      },
    );
  }
}
