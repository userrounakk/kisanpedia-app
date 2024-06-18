import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kisanpedia_app/controllers/dashboard_controller.dart';
import 'package:kisanpedia_app/controllers/plant_controller.dart';
import 'package:kisanpedia_app/controllers/seller_controller.dart';
import 'package:kisanpedia_app/controllers/store_controller.dart';
import 'package:kisanpedia_app/helpers/constants/text.dart';
import 'package:kisanpedia_app/helpers/images/images.dart';
import 'package:kisanpedia_app/models/plant.dart';
import 'package:kisanpedia_app/models/seller.dart';
import 'package:kisanpedia_app/models/store.dart';
import 'package:kisanpedia_app/pages/dashboard-pages/contact.dart';
import 'package:kisanpedia_app/pages/dashboard-pages/home.dart';
import 'package:kisanpedia_app/pages/dashboard-pages/plants.dart';
import 'package:kisanpedia_app/pages/dashboard-pages/sellers.dart';
import 'package:kisanpedia_app/pages/dashboard-pages/stores.dart';
import 'package:kisanpedia_app/widgets/text.dart';

class Dashboard extends StatelessWidget {
  static const routeName = '/dashboard';
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final dashboardController = Get.find<DashboardController>();
    // plant controller variables.
    final plantController = Get.find<PlantController>();
    List<Plant> plants = plantController.plants;
    bool plantError = plantController.plantError.value;
    // seller controller variables.
    final sellerController = Get.find<SellerController>();
    List<Seller> sellers = sellerController.sellers;
    bool sellerError = sellerController.sellerError.value;
    // store controller variables.
    final storeController = Get.find<StoreController>();
    List<Store> stores = storeController.stores;
    bool storeError = storeController.storeError.value;
    List<Widget> pages = [
      Home(
          plants: plants,
          plantHasError: plantError,
          sellers: sellers,
          sellerHasError: sellerError),
      PlantPage(plants: plants, hasError: plantError),
      SellerPage(sellers: sellers, hasError: sellerError),
      StorePage(stores: stores, hasError: storeError),
      const ContactPage(),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: CustomText.title(appName, size: 22),
        leading: Image.asset(Images.logo, height: 40),
        centerTitle: false,
      ),
      body: Obx(
        () => IndexedStack(
          index: dashboardController.currentPageIndex.value,
          children: pages,
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          iconSize: 32,
          onTap: (value) => dashboardController.currentPageIndex.value = value,
          currentIndex: dashboardController.currentPageIndex.value,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.yard),
              label: "Plants",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Sellers",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.store),
              label: "Stores",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.phone),
              label: "Contact",
            ),
          ],
        ),
      ),
    );
  }
}
