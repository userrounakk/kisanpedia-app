import 'package:flutter/material.dart';
import 'package:kisanpedia_app/helpers/constants/text.dart';
import 'package:kisanpedia_app/helpers/images/images.dart';
import 'package:kisanpedia_app/models/plant.dart';
import 'package:kisanpedia_app/pages/dashboard-pages/home.dart';
import 'package:kisanpedia_app/pages/dashboard-pages/plants.dart';
import 'package:kisanpedia_app/services/api.dart';
import 'package:kisanpedia_app/widgets/text.dart';

class Dashboard extends StatefulWidget {
  static const routeName = '/dashboard';
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Plant> plants = [];
  bool plantError = false;

  @override
  void initState() {
    _loadPlantData();
    super.initState();
  }

  Future<void> _loadPlantData() async {
    try {
      var res = await Api.getPlants();
      setState(() {
        plants = plantResponseFromJson(res.body).plant;
      });
    } catch (e) {
      setState(() {
        plantError = true;
      });
    }
  }

  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      Home(plants: plants, hasError: plantError),
      PlantPage(plants: plants, hasError: plantError),
      const Text("Sellers"),
      const Text("Stores"),
      const Text("Contact"),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: CustomText.title(appName, size: 22),
        leading: Image.asset(Images.logo, height: 40),
        centerTitle: false,
      ),
      body: IndexedStack(
        index: currentPageIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 32,
        onTap: (value) => setState(() {
          currentPageIndex = value;
        }),
        currentIndex: currentPageIndex,
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
    );
  }
}
