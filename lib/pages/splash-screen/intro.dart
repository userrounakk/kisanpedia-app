import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kisanpedia_app/controllers/plant_controller.dart';
import 'package:kisanpedia_app/controllers/seller_controller.dart';
import 'package:kisanpedia_app/helpers/colors/theme.dart';
import 'package:kisanpedia_app/helpers/constants/text.dart';
import 'package:kisanpedia_app/helpers/dimension.dart';
import 'package:kisanpedia_app/helpers/images/images.dart';
import 'package:kisanpedia_app/helpers/spacer.dart';
import 'package:kisanpedia_app/models/plant.dart';
import 'package:kisanpedia_app/models/seller.dart';
import 'package:kisanpedia_app/pages/dashboard.dart';
import 'package:kisanpedia_app/pages/no_internet.dart';
import 'package:kisanpedia_app/pages/onboarding/onboarding.dart';
import 'package:kisanpedia_app/services/api.dart';
import 'package:kisanpedia_app/widgets/text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatefulWidget {
  static const routeName = '/intro';
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  bool _isMounted = false;
  bool timerRunning = true;
  bool dataFetched = false;
  int sec = 0;
  String redirect = OnboardingScreen.routeName;
  final PlantController plantController = Get.find<PlantController>();
  final SellerController sellerController = Get.find<SellerController>();
  @override
  void initState() {
    _isMounted = true;
    updateTimer();
    Future.wait([_loadPlantData(), _loadSellerData()]).then((_) {
      if (_isMounted) {
        setState(() {
          dataFetched = true;
          if (Get.isBottomSheetOpen ?? false) {
            Get.back();
          }
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }

  Future<void> _loadPlantData() async {
    debugPrint("Loading plant data");
    try {
      var res = await Api.getPlants();
      plantController.setPlants(plantResponseFromJson(res.body).plant);
      plantController.setError(false);
    } on SocketException catch (e) {
      if (e.osError?.errorCode == 101) {
        Get.snackbar("Internet issue",
            "Please check your internet connection and try again");
        Get.offAllNamed(NoInternet.routeName);
        return;
      }
    } catch (e) {
      plantController.setError(true);
    }
  }

  Future<void> _loadSellerData() async {
    debugPrint("Loading seller data");
    try {
      var res = await Api.getSellers();
      sellerController.setSellers(sellerResponseFromJson(res.body).seller);
      sellerController.setError(false);
    } catch (e) {
      sellerController.setError(true);
    }
  }

  void updateTimer() async {
    final preferences = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 1));
    if (_isMounted) {
      setState(() {
        sec++;
      });
    }
    // change the sec value to 10
    if (sec == 3) {
      if (!dataFetched) {
        Get.bottomSheet(
          Container(
            color: Colors.white,
            height: 400,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.signal_wifi_statusbar_connected_no_internet_4,
                  size: 100,
                  color: Colors.red,
                ),
                const Text(
                  "Slow internet Connection.",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Please wait for a while.",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Image.asset(Images.loadingGif, height: 100)
              ],
            ),
          ),
          isDismissible: false,
          enableDrag: false,
        );
      }
      if (preferences.containsKey("onboardingCompleted")) {
        redirect = Dashboard.routeName;
      }
      timerRunning = false;
      if (_isMounted) {
        setState(() {});
      }
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
