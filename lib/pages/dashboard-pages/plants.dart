import 'package:flutter/material.dart';
import 'package:kisanpedia_app/helpers/dimension.dart';
import 'package:kisanpedia_app/helpers/images/images.dart';
import 'package:kisanpedia_app/models/plant.dart';
import 'package:kisanpedia_app/services/api.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PlantPage extends StatefulWidget {
  final List<Plant> plants;
  final bool hasError;
  const PlantPage({required this.plants, required this.hasError, super.key});

  @override
  State<PlantPage> createState() => _PlantPageState();
}

class _PlantPageState extends State<PlantPage> {
  late List<Plant> filteredPlants;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    filteredPlants = List.from(widget.plants);
    super.initState();
  }

  void filterPlants() {
    var searchValue = searchController.text;
    if (searchValue.isEmpty) {
      filteredPlants = List.from(widget.plants);
      setState(() {});
      return;
    }
    filteredPlants = widget.plants.where((plant) {
      return plant.name.toLowerCase().contains(searchValue.toLowerCase());
    }).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = Dimension.getHeight(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          SizedBox(
            height: screenHeight * .06,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: TextFormField(
                onChanged: (value) => filterPlants(),
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search plants',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: Dimension.getHeight(context) * .75 - 20,
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(16.0),
                  sliver: widget.hasError
                      ? const SliverFillRemaining(
                          child: Center(
                            child: Text('Failed to load plants'),
                          ),
                        )
                      : widget.plants.isEmpty
                          ? const SliverFillRemaining(
                              child: Center(child: CircularProgressIndicator()),
                            )
                          : filteredPlants.isEmpty
                              ? const SliverFillRemaining(
                                  child: Center(
                                    child: Text('No plants found'),
                                  ),
                                )
                              : SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                      return _buildPlantItem(
                                          context, filteredPlants[index]);
                                    },
                                    childCount: filteredPlants.length,
                                  ),
                                ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlantItem(BuildContext context, Plant plant) {
    double screenWidth = Dimension.getWidth(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: SizedBox(
        width: screenWidth - 45,
        child: Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: InkWell(
            onTap: () {
              // TODO: Navigate to plant detail page
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: CachedNetworkImage(
                      imageUrl: Api.baseUrl + plant.image,
                      placeholder: (context, url) =>
                          Image.asset(Images.loadingGif),
                      errorWidget: (context, url, error) =>
                          Image.asset(Images.placeHolder("plant")),
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          plant.name,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          plant.description,
                          style: const TextStyle(fontSize: 14.0),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Rs ${plant.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
