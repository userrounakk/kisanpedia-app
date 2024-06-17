import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kisanpedia_app/helpers/colors/theme.dart';
import 'package:kisanpedia_app/pages/dashboard.dart';
import 'package:kisanpedia_app/pages/onboarding/onboarding.dart';
import 'package:kisanpedia_app/pages/splash-screen/intro.dart';
import 'package:kisanpedia_app/pages/splash-screen/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Kisanpedia',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: theme),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Comfortaa',
        useMaterial3: true,
        primarySwatch: theme,
        canvasColor: Colors.white,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.transparent,
        ),
      ),
      initialRoute: Splash.routeName,
      getPages: [
        GetPage(
          name: Splash.routeName,
          page: () => const Splash(),
        ),
        GetPage(
          name: IntroScreen.routeName,
          page: () => const IntroScreen(),
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: Dashboard.routeName,
          page: () => const Dashboard(),
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: OnboardingScreen.routeName,
          page: () => const OnboardingScreen(),
          transition: Transition.fadeIn,
        ),
      ],
    );
  }
}
