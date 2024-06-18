import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kisanpedia_app/helpers/dimension.dart';
import 'package:kisanpedia_app/models/store.dart';
import 'package:url_launcher/url_launcher.dart';

class StorePage extends StatefulWidget {
  final List<Store> stores;
  final bool hasError;
  const StorePage({required this.stores, required this.hasError, super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  late List<Store> filteredStores;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    filteredStores = List.from(widget.stores);
    super.initState();
  }

  void filterPlants() {
    var searchValue = searchController.text;
    if (searchValue.isEmpty) {
      filteredStores = List.from(widget.stores);
      setState(() {});
      return;
    }
    filteredStores = widget.stores.where((plant) {
      return plant.name.toLowerCase().contains(searchValue.toLowerCase());
    }).toList();
    setState(() {});
  }

  Future<void> _launchUrl(String url) async {
    Uri uri = Uri.parse(url);
    try {
      if (!await launchUrl(uri)) {
        throw 'Could not launch $uri';
      }
    } catch (e) {
      Get.snackbar("Error loading map.", "Please try again later.");
    }
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
                  hintText: 'Search Stores',
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
                            child: Text('Failed to load Stores'),
                          ),
                        )
                      : widget.stores.isEmpty
                          ? const SliverFillRemaining(
                              child: Center(child: CircularProgressIndicator()),
                            )
                          : filteredStores.isEmpty
                              ? const SliverFillRemaining(
                                  child: Center(
                                    child: Text('No Stores found'),
                                  ),
                                )
                              : SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                      return _buildStoreItem(
                                          context, filteredStores[index]);
                                    },
                                    childCount: filteredStores.length,
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

  Widget _buildStoreItem(BuildContext context, Store store) {
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
            onTap: () => Get.dialog(AlertDialog(
              title: Text(store.name),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(store.city),
                  Text(store.street),
                  Text(store.address),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Get.back(),
                  child: const Text('Close'),
                ),
                TextButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        Theme.of(context).primaryColor,
                      ),
                    ),
                    onPressed: () => _launchUrl(store.mapInfo),
                    child: const Text(
                      "View",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )),
              ],
            )),
            child: ListTile(
              leading: const Icon(Icons.store),
              title: Text(store.name),
              subtitle: Text(store.city),
              trailing: IconButton(
                onPressed: () => _launchUrl(store.mapInfo),
                icon: const Icon(
                  Icons.location_on_outlined,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
