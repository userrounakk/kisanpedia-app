import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:kisanpedia_app/helpers/dimension.dart';
import 'package:kisanpedia_app/helpers/images/images.dart';
import 'package:kisanpedia_app/pages/splash-screen/intro.dart';

class Splash extends StatefulWidget {
  static const routeName = '/splash';
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    navigateToHome();
    super.initState();
  }

  void navigateToHome() async {
    await Future.delayed(Duration(seconds: 3));
    Get.offNamed(IntroScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      height: Dimension.getHeight(context),
      width: Dimension.getWidth(context),
      child: Image.asset(
        Images.splashGif,
        fit: BoxFit.cover,
      ),
    ));
  }
}
