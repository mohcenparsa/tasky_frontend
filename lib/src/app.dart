import 'package:flutter/material.dart';
import 'package:tasky/src/components/setup/localization_setup.dart';
import 'package:tasky/src/components/setup/route_generator.dart';
import 'package:tasky/src/pages/login_page.dart';
import 'components/common/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      restorationScopeId: 'app',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: LocalizationSetup.localizationsDelegates,
      supportedLocales: LocalizationSetup.supportedLocales,
      onGenerateTitle: (BuildContext context) =>
          LocalizationSetup.getTitle(context),
      // theme: ThemeSetup.lightTheme,
      // darkTheme: ThemeSetup.darkTheme,
      onGenerateRoute: (RouteSettings routeSettings) {
        return RouteGenerator.generateRoute(routeSettings);
      },
      initialRoute: '/',
      home: FutureBuilder(
        future: Future.delayed(const Duration(seconds: 3)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
