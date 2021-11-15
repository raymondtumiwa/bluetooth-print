import 'package:flutter/material.dart';
import 'package:my_app/pages/pickup_completed.dart';
import 'package:my_app/pages/pickup_confirmed.dart';
import 'package:my_app/pages/pickup_list.dart';
// import 'package:giffy_dialog/giffy_dialog.dart';

class PickUp extends StatefulWidget {
  //int _selectedIndex = 0;
  @override
  _PickUpState createState() => _PickUpState();
  static _PickUpState? of(BuildContext context) =>
      context.findAncestorStateOfType<_PickUpState>();
}

class _PickUpState extends State<PickUp> {
  int _selectedIndex = 0;
  int itemCount = 7;

  set changeSelectedNavBar(int index) => setState(() {
        _selectedIndex = index;
      });
  get getSelectedNavBar => _selectedIndex;

  void change(int index) {
    changeSelectedNavBar = index;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    PickUpList(),
    PickUpConfirmed(),
    PickUpCompleted(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.motorcycle),
            label: 'Pickup',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm),
            label: 'Jobs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm),
            label: 'Completed',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: change,
      ),
    );
  }
}
