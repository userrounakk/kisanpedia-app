import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:kisanpedia_app/helpers/colors/theme.dart';
import 'package:kisanpedia_app/helpers/constants/text.dart';
import 'package:kisanpedia_app/helpers/dimension.dart';
import 'package:kisanpedia_app/helpers/images/images.dart';
import 'package:kisanpedia_app/helpers/spacer.dart';
import 'package:kisanpedia_app/pages/dashboard.dart';
import 'package:kisanpedia_app/pages/onboarding/onboarding.dart';
import 'package:kisanpedia_app/widgets/text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatefulWidget {
  static const routeName = '/intro';
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  bool timerRunning = true;
  int sec = 0;
  String redirect = OnboardingScreen.routeName;
  @override
  void initState() {
    updateTimer();
    super.initState();
    // checkRedirect();
  }

  void checkRedirect() async {
    final preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey("onboardingCompleted")) {
      setState(() {
        redirect = Dashboard.routeName;
      });
    }
    return;
  }

  void updateTimer() async {
    final preferences = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      sec++;
    });
    // change the sec value to 10
    if (sec == 3) {
      if (preferences.containsKey("onboardingCompleted")) {
        redirect = Dashboard.routeName;
      }
      timerRunning = false;
      setState(() {});
    } else {
      updateTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = Dimension.getHeight(context);
    final screenWidth = Dimension.getWidth(context);
    return Scaffold(
      body: SizedBox(
        height: screenHeight,
        width: screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: screenHeight * .3,
              width: screenHeight * .3,
              child: Image.asset(
                Images.logo,
                fit: BoxFit.cover,
              ),
            ),
            CustomText.title(
              appName,
              size: 30,
            ),
            const CustomSpace(),
            CustomText.subtitle(subtitleLine1),
            const CustomSpace(),
            CustomText.subtitle(subTitleLine2),
            const CustomSpace(),
            EnterButton(
                screenWidth: screenWidth,
                timerRunning: timerRunning,
                sec: sec,
                onPressed: () {
                  if (timerRunning) {
                    return null;
                  }
                  return () {
                    Get.offNamed(redirect);
                  };
                }),
            const CustomSpace(),
            CustomText.subtitle("Technology Partner"),
            const CustomSpace(),
            Image.asset(
              Images.pracasLogo,
              height: screenHeight * .2,
            ),
            CustomText.subtitle(
              "Made in Biratnagar",
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}

class EnterButton extends StatelessWidget {
  const EnterButton({
    super.key,
    required this.screenWidth,
    required this.timerRunning,
    required this.sec,
    required this.onPressed,
  });

  final double screenWidth;
  final bool timerRunning;
  final int sec;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth * .6,
      child: TextButton(
        style: ButtonStyle(
            shape: WidgetStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
            backgroundColor: timerRunning
                ? WidgetStateProperty.all(Colors.grey)
                : WidgetStateProperty.all(theme.shade500)),
        onPressed: onPressed(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            timerRunning ? "Enter in ${10 - sec} seconds" : "Enter",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
