import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:kisanpedia_app/helpers/dimension.dart';
import 'package:kisanpedia_app/helpers/images/images.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  Future<void> _launchUrl(String url) async {
    Uri uri = Uri.parse(url);
    try {
      if (!await launchUrl(uri)) {
        throw 'Could not launch $uri';
      }
    } catch (e) {
      Get.snackbar("Error loading Url.", "Please try again later.");
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = Dimension.getHeight(context);
    final double screenWidth = Dimension.getWidth(context);
    return Container(
      height: screenHeight,
      width: screenWidth,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: screenHeight * .3,
              width: screenWidth,
              child: Center(
                child: Image.asset(
                  Images.pracasLogo,
                  height: screenHeight * .3,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Contact Us",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () => _launchUrl(
                  "https://www.google.com/maps?client=opera&oe=UTF-8&um=1&ie=UTF-8&fb=1&gl=np&sa=X&geocode=KeG1AztHdO85MV50dPTSyKvX&daddr=Himalaya+Rd,+Biratnagar+56613"),
              child: const Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Above Nepal SBI Bank Ltd."),
                      Text("Himalayan Road, Biratnagar, Nepal.")
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () => _launchUrl("mailto:kisanpedia@pracas.net"),
              child: const Row(
                children: [
                  Icon(
                    Icons.mail,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text("kisanpedia@pracas.net"),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Icon(
                  Icons.phone,
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () => _launchUrl("tel:+9779852024365"),
                      child: const Text("+977-9852024365 [Membership]"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () => _launchUrl("tel:+9779852030410"),
                      child: const Text("+977-9852030410 [Business]"),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () => _launchUrl("https://www.kisanpedia.com"),
              child: const Row(
                children: [
                  Icon(
                    Icons.language,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text("https://www.kisanpedia.com"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
