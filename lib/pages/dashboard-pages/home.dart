import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kisanpedia_app/controllers/dashboard_controller.dart';
import 'package:kisanpedia_app/helpers/dimension.dart';
import 'package:kisanpedia_app/helpers/images/images.dart';
import 'package:kisanpedia_app/models/plant.dart';
import 'package:kisanpedia_app/models/seller.dart';
import 'package:kisanpedia_app/pages/detail-pages/plant_detail.dart';
import 'package:kisanpedia_app/pages/detail-pages/seller_detail.dart';
import 'package:kisanpedia_app/services/api.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Home extends StatelessWidget {
  final List<Plant> plants;
  final bool plantHasError;

  final List<Seller> sellers;
  final bool sellerHasError;

  const Home({
    super.key,
    required this.plants,
    this.plantHasError = false,
    required this.sellers,
    this.sellerHasError = false,
  });

  @override
  Widget build(BuildContext context) {
    final dashboardController = Get.find<DashboardController>();
    final double screenHeight = Dimension.getHeight(context);
    final double screenWidth = Dimension.getWidth(context);
    final slider = Images.sliderImages.map((image) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          image,
          fit: BoxFit.cover,
          colorBlendMode: BlendMode.darken,
          color: Colors.black.withOpacity(.2),
        ),
      );
    }).toList();
    return SingleChildScrollView(
      child: SizedBox(
        // height: screenHeight,
        width: screenWidth,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: screenHeight * .25,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    viewportFraction: .85,
                    aspectRatio: 1 / 2,
                  ),
                  items: slider,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ListTile(
                title: const Text(
                  'Plants',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                trailing: TextButton(
                  child: const Text(
                    'View All',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () =>
                      dashboardController.currentPageIndex.value = 1,
                ),
              ),
              plantHasError
                  ? const Text(
                      "Couldn't load plants. Please check your network connection")
                  : plants.isEmpty
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : SizedBox(
                          height: screenHeight > 700
                              ? screenHeight * .2
                              : screenHeight * .3,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            children: plants.map(
                              (plant) {
                                return InkWell(
                                  onTap: () {
                                    Get.toNamed(PlantDetail.routeName,
                                        arguments: plant);
                                    // dashboardController.currentPageIndex.value =
                                    //     1;
                                  },
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  Api.baseUrl + plant.image,
                                              placeholder: (context, url) =>
                                                  Image.asset(
                                                      Images.loadingGif),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Image.asset(
                                                          Images.placeHolder(
                                                              "plant")),
                                              width: screenHeight * .12,
                                              height: screenHeight * .12,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            plant.name,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                        ),
              ListTile(
                title: const Text(
                  'Sellers',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                trailing: TextButton(
                  child: const Text(
                    'View All',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () =>
                      dashboardController.currentPageIndex.value = 2,
                ),
              ),
              sellerHasError
                  ? const Text(
                      "Couldn't load sellers. Please check your network connection")
                  : sellers.isEmpty
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : SizedBox(
                          height: screenHeight > 700
                              ? screenHeight * .2
                              : screenHeight * .3,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            children: sellers.map(
                              (seller) {
                                return InkWell(
                                  onTap: () => Get.toNamed(
                                      SellerDetail.routeName,
                                      arguments: seller),
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  Api.baseUrl + seller.image,
                                              placeholder: (context, url) =>
                                                  Image.asset(
                                                      Images.loadingGif),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Image.asset(
                                                          Images.placeHolder(
                                                              "seller")),
                                              width: screenHeight * .12,
                                              height: screenHeight * .12,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            seller.name,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                        ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
