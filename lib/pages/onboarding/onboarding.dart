import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kisanpedia_app/helpers/colors/theme.dart';
import 'package:kisanpedia_app/helpers/constants/onboarding.dart';
import 'package:kisanpedia_app/helpers/dimension.dart';
import 'package:kisanpedia_app/pages/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  static const routeName = '/onboarding';
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();
  bool isLastPage = false;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = Dimension.getHeight(context);
    List<Widget> pages = onboardingScreenContent.map((content) {
      return buildPage(
        screenHeight: screenHeight, // Ensure screenHeight is defined somewhere
        urlImage: content['urlImage']!,
        title: content['title']!,
        subtitle: content['subtitle']!,
        position: content['position']!,
      );
    }).toList();
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: screenHeight * 0.30),
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() => isLastPage = index == pages.length - 1);
          },
          children: pages,
        ),
      ),
      bottomSheet: isLastPage
          ? Container(
              padding: EdgeInsets.only(
                  left: 30, right: 30, bottom: screenHeight > 700 ? 130 : 80),
              height: screenHeight * 0.30,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: screenHeight * 0.01),
                  Center(
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: pages.length,
                      effect: const WormEffect(
                        spacing: 16,
                        dotColor: Colors.grey,
                        activeDotColor: Color(0xFF4b4b4b),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  TextButton(
                    onPressed: () async {
                      final preferences = await SharedPreferences.getInstance();
                      preferences.setBool('onboardingCompleted', true);
                      Get.offNamed(Dashboard.routeName);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme,
                      shape: const StadiumBorder(),
                      fixedSize: const Size(140, 35),
                    ),
                    child: const Text(
                      'GET STARTED',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Container(
              padding: EdgeInsets.only(
                  left: 30, right: 30, bottom: screenHeight > 700 ? 80 : 40),
              height: screenHeight * 0.30,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: screenHeight * 0.01),
                  Center(
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: pages.length,
                      effect: const WormEffect(
                        spacing: 16,
                        dotColor: Colors.grey,
                        activeDotColor: theme,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () => controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme,
                          shape: const StadiumBorder(),
                          fixedSize: const Size(140, 35),
                        ),
                        child: const Text(
                          'CONTINUE',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextButton(
                        onPressed: () => controller.jumpToPage(4),
                        child: const Text(
                          'Skip',
                          style: TextStyle(
                            color: Color(0xFF4b4b4b),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
    );
  }
}

Widget buildPage({
  required String urlImage,
  required String title,
  required String subtitle,
  required String position,
  required double screenHeight,
}) {
  return Container(
    padding: const EdgeInsets.fromLTRB(17, 50, 17, 0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          urlImage,
          fit: BoxFit.contain,
          height: screenHeight * 0.25,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.022),
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF4b4b4b),
                fontSize: 20,
              ),
            ),
          ),
        ),
        Text(
          subtitle,
          maxLines: 6,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          position,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF4b4b4b),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
