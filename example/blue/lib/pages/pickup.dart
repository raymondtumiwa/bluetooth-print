import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:blue/models/pickup.dart';
import 'package:blue/pages/pickup_confirm.dart';
import 'package:blue/pages/pickup_detail.dart';
import 'package:blue/pages/pickup_list.dart';
// import 'package:giffy_dialog/giffy_dialog.dart';
import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

class PickUp extends StatefulWidget {
  //int _selectedIndex = 0;
  @override
  _PickUpState createState() => _PickUpState();
}

// STEP1:  Stream setup

// class bookings {
//   String abc;
// }

class _PickUpState extends State<PickUp> {
  int _selectedIndex = 0;
  int itemCount = 7;

  void _changeSelectedNavBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    PickUpListComponent(),
    PickUpConfirmed(),
  ];
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
            icon: Icon(Icons.done),
            label: 'Confirm Alarm',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _changeSelectedNavBar,
      ),
    );
  }
}
