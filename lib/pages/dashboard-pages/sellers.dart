import 'package:flutter/material.dart';
import 'package:kisanpedia_app/helpers/dimension.dart';
import 'package:kisanpedia_app/helpers/images/images.dart';
import 'package:kisanpedia_app/models/seller.dart';
import 'package:kisanpedia_app/services/api.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SellerPage extends StatefulWidget {
  final List<Seller> sellers;
  final bool hasError;
  const SellerPage({required this.sellers, required this.hasError, super.key});

  @override
  State<SellerPage> createState() => _SellerPageState();
}

class _SellerPageState extends State<SellerPage> {
  late List<Seller> filteredSellers;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    filteredSellers = List.from(widget.sellers);
    super.initState();
  }

  void filterPlants() {
    var searchValue = searchController.text;
    if (searchValue.isEmpty) {
      filteredSellers = List.from(widget.sellers);
      setState(() {});
      return;
    }
    filteredSellers = widget.sellers.where((plant) {
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
                  hintText: 'Search Sellers',
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
                            child: Text('Failed to load sellers'),
                          ),
                        )
                      : widget.sellers.isEmpty
                          ? const SliverFillRemaining(
                              child: Center(child: CircularProgressIndicator()),
                            )
                          : filteredSellers.isEmpty
                              ? const SliverFillRemaining(
                                  child: Center(
                                    child: Text('No Seller found'),
                                  ),
                                )
                              : SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                      return _buildSellerItem(
                                          context, filteredSellers[index]);
                                    },
                                    childCount: filteredSellers.length,
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

  Widget _buildSellerItem(BuildContext context, Seller seller) {
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
              // TODO: Navigate to seller detail page
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: CachedNetworkImage(
                      imageUrl: Api.baseUrl + seller.image,
                      placeholder: (context, url) =>
                          Image.asset(Images.loadingGif),
                      errorWidget: (context, url, error) =>
                          Image.asset(Images.placeHolder("seller")),
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
                          seller.name,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          seller.description,
                          style: const TextStyle(fontSize: 14.0),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8.0),
                        // Text(
                        //   'Rs ${plant.price.toStringAsFixed(2)}',
                        //   style: const TextStyle(
                        //     fontSize: 16.0,
                        //     fontWeight: FontWeight.bold,
                        //     color: Colors.green,
                        //   ),
                        // ),
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
