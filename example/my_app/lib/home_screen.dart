import 'package:flutter/material.dart';
import 'package:my_app/pages/delivery.dart';
import 'package:my_app/pages/pickup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var currentPage = DrawerSections.delivery;
  Future<void> logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  @override
  Widget build(BuildContext context) {
    StatefulWidget container;
    if (currentPage == DrawerSections.delivery) {
      container = DeliveryPage();
    } else if (currentPage == DrawerSections.pickup) {
      container = PickUp();
    } else {
      container = PickUp();
    }
    container = PickUp();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[700],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("DRIVER"),
              IconButton(
                  onPressed: () {
                    logoutUser();
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  icon: const Icon(Icons.logout, color: Colors.white))
            ],
          ),
        ),
        body: container,
        drawer: Drawer(
          child: SingleChildScrollView(
            child: Column(
              children: [
                myDrawerList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget myDrawerList() {
    return Container(
      padding: const EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "Delivery", Icons.dashboard_outlined,
              currentPage == DrawerSections.delivery ? true : false),
          menuItem(2, "Pick Up", Icons.people_alt_outlined,
              currentPage == DrawerSections.pickup ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.delivery;
            } else if (id == 2) {
              currentPage = DrawerSections.pickup;
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSections {
  pickup,
  delivery,
}
