import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kisanpedia_app/helpers/dimension.dart';
import 'package:kisanpedia_app/helpers/images/images.dart';
import 'package:kisanpedia_app/models/plant.dart';
import 'package:kisanpedia_app/services/api.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Home extends StatelessWidget {
  final List<Plant> plants;
  final bool hasError;
  const Home({
    super.key,
    required this.plants,
    this.hasError = false,
  });

  @override
  Widget build(BuildContext context) {
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
        height: screenHeight,
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
                onTap: () {
                  Navigator.pushNamed(context, '/plants');
                },
              ),
              hasError
                  ? const Text(
                      "Couldn't load plants. Please check your network connection")
                  : plants.isEmpty
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : SizedBox(
                          height: screenHeight * .175,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            children: plants.map(
                              (plant) {
                                return Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: CachedNetworkImage(
                                            imageUrl: Api.baseUrl + plant.image,
                                            height: 80,
                                            width: 80,
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
                                );
                              },
                            ).toList(),
                          ),
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
