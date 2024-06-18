import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kisanpedia_app/controllers/dashboard_controller.dart';
import 'package:kisanpedia_app/controllers/plant_controller.dart';
import 'package:kisanpedia_app/controllers/seller_controller.dart';
import 'package:kisanpedia_app/helpers/constants/bottom_nav.dart';
import 'package:kisanpedia_app/helpers/constants/text.dart';
import 'package:kisanpedia_app/helpers/dimension.dart';
import 'package:kisanpedia_app/helpers/images/images.dart';
import 'package:kisanpedia_app/models/plant.dart';
import 'package:kisanpedia_app/models/seller.dart';
import 'package:kisanpedia_app/pages/dashboard.dart';
import 'package:kisanpedia_app/services/api.dart';
import 'package:kisanpedia_app/widgets/text.dart';

class PlantDetail extends StatelessWidget {
  PlantDetail({super.key});
  static const routeName = '/plant-detail';
  final Plant plant = Get.arguments ?? Get.find<PlantController>().plants[0];
  final SellerController sellerController = Get.find<SellerController>();
  List<Seller> filterSellers() {
    final allSellers = sellerController.sellers;
    return allSellers.where((seller) {
      return seller.products.contains(plant.name);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final dashboardController = Get.find<DashboardController>();
    final double screenHeight = Dimension.getHeight(context);
    final double screenWidth = Dimension.getWidth(context);
    final sellers = filterSellers();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: CustomText.title(appName, size: 22),
        leading: Image.asset(Images.logo, height: 40),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.grey.shade800),
                  ),
                  padding: const EdgeInsets.all(2),
                  margin: const EdgeInsets.all(20),
                  child: CachedNetworkImage(
                    imageUrl: Api.baseUrl + plant.image,
                    placeholder: (context, url) =>
                        Image.asset(Images.loadingGif),
                    errorWidget: (context, url, error) => Image.asset(
                      Images.placeHolder("plant"),
                      fit: BoxFit.cover,
                    ),
                    width: screenHeight * .2,
                    height: screenHeight * .2,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                plant.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                'MRP: Rs. ${plant.price}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Locations: ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5.0),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    clipBehavior: Clip.hardEdge,
                    children: plant.location
                        .map((location) => Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Theme.of(context).primaryColor,
                              ),
                              child: Text(
                                '$location ',
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ))
                        .toList(),
                  )
                ],
              ),
              const SizedBox(height: 30.0),
              const Text(
                "Description:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5.0),
              Text(
                plant.description,
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 30.0),
              const Text(
                "Sellers:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              sellers.isEmpty
                  ? const Center(
                      child: Text(
                        "No sellers found",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : SizedBox(
                      height: screenHeight * .12,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: sellers.length,
                        itemBuilder: (context, index) {
                          final seller = sellers[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: screenWidth * .8,
                              child: Card(
                                child: ListTile(
                                  title: Text(
                                    seller.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(seller.phoneNumber),
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl: Api.baseUrl + seller.image,
                                      placeholder: (context, url) =>
                                          Image.asset(Images.loadingGif),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                        Images.placeHolder("seller"),
                                        fit: BoxFit.contain,
                                      ),
                                      width: screenHeight * .08,
                                      height: screenHeight * .08,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 32,
        onTap: (value) {
          dashboardController.currentPageIndex.value = value;
          Get.offNamedUntil(Dashboard.routeName, (route) => false);
        },
        currentIndex: 1,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        items: bottomNavItems,
      ),
    );
  }
}
