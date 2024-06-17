import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kisanpedia_app/helpers/constants/text.dart';
import 'package:kisanpedia_app/helpers/images/images.dart';
import 'package:kisanpedia_app/widgets/text.dart';

class Dashboard extends StatefulWidget {
  static const routeName = '/dashboard';
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int currentPageIndex = 0;
  List<Widget> pages = const [
    Text("Home"),
    Text("Plants"),
    Text("Sellers"),
    Text("Stores"),
    Text("Contact"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: CustomText.title(appName, size: 22),
        leading: Image.asset(Images.logo, height: 40),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: pages[currentPageIndex],
        ),
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
