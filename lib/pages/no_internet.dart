import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kisanpedia_app/helpers/dimension.dart';
import 'package:kisanpedia_app/pages/splash-screen/intro.dart';
import 'package:kisanpedia_app/services/api.dart';

class NoInternet extends StatefulWidget {
  static const routeName = '/no-internet';
  const NoInternet({super.key});

  @override
  State<NoInternet> createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> {
  @override
  void initState() {
    super.initState();
    checkInternet();
  }

  Future<void> checkInternet() async {
    try {
      final res = await Api.checkInternet();
      if (res.statusCode == 200) {
        return Get.offNamed(IntroScreen.routeName);
      }
    } on SocketException {
      return checkInternet();
    } catch (e) {
      Get.snackbar("Error",
          "Something went wrong. Please restart the application to continue");
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: Dimension.getHeight(context),
        width: double.infinity,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.signal_wifi_off_outlined, size: 100, color: Colors.grey),
            Text(
              "No internet Connection.",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
