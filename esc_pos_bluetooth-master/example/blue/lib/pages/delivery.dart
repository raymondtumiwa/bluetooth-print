import 'package:flutter/material.dart';
import 'package:blue/pages/confirm.dart';
import 'package:blue/pages/delivery_list.dart';
import 'package:blue/services/onrest.dart';
// import 'package:giffy_dialog/giffy_dialog.dart';
import '../services/globals.dart' as globals;

class DeliveryPage extends StatefulWidget {
  @override
  _DeliveryPageState createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  var deliveryList = [];
  bool isValid = false;
  // void initState() {
  //   super.initState();

  //   print("cuma mencoba coba");
  //   OnRestBanner.instance
  //       .blogList(0, 4, "forward", "", "")
  //       .then((value) => setState(() {
  //             print("mond");
  //             print(value);
  //             print(value.runtimeType);
  //             print("hurt");
  //             print(value['data'].length);
  //             blogList = [];
  //             blogTitle = [];
  //             blogLink = [];
  //             blogDept = [];
  //             for (var i = 0; i < value['data'].length; [i++]) {
  //               blogList.add(value['data'][i]['image_url']);
  //               blogTitle.add(value['data'][i]['title']);
  //               blogLink.add(value['data'][i]['url']);
  //               blogDept.add(value['data'][i]['dept']);
  //             }
  //             print("qawqeqeqeaeaea");
  //             print(blogList);
  //             print(blogTitle);
  //             print(blogLink);
  //             // print(blogDate);
  //           }));
  //   setState(() {});
  //   //     }).showAlertIfNecessary();
  // }

  @override
  void initState() {
    super.initState();
    OnRest.instance
        .listDelivery(globals.agentLocId, globals.courierId, "")
        .then((value) {
      if (value != null) {
        print(value);
        print("postttttt");
        print(value.length);
        setState(() {
          for (int i = 0; i < value.length; i++) {
            deliveryList.add(value[i]);
            print(deliveryList);
          }
          print(deliveryList);
          isValid = true;
        });
        // setState(() {
        //   globals.fleetId = value['fleetId'];
        //   globals.checkInTime = value['checkInTime'];
        //   globals.tripId = value['tripId'];
        //   globals.latLongIn = value['latLongIn'];
        // });
        // Navigator.of(context).pushNamedAndRemoveUntil(
        //     '/checkin', (Route<dynamic> route) => false);
      }
    }).catchError((ee) {
      print(ee);
    });
  }

  get bottomNavigationBar => null;

  int _selectedIndex = 0;

  void _changeSelectedNavBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    DeliveryList(),
    ConfirmList(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.task),
            label: 'Delivery List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done),
            label: 'Confirm',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
  // Widget build(BuildContext context) {
  //   return Scaffold(

  //     bottomNavigationBar: BottomNavigationBar(
  //       items: const <BottomNavigationBarItem>[
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.motorcycle),
  //           label: 'Pickup',
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.check_circle),
  //           label: 'Confirm',
  //         ),
  //       ],
  //       currentIndex: _selectedIndex,
  //       selectedItemColor: Colors.blue,
  //       unselectedItemColor: Colors.grey,
  //       showUnselectedLabels: true,
  //       onTap: _changeSelectedNavBar,
  //     ),
  //   );
  // }
}






// body: 





// Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _animateToIndex(10),
//         child: Icon(Icons.arrow_downward),
//       ),
//       body: ListView.builder(
//         controller: _controller,
//         itemCount: 100,
//         itemBuilder: (_, i) => Container(
//           height: _height,
//           child: Card(child: Center(child: Text("Item $i"))),
//         ),
//       ),
//     );
//   }


  //     context: context,builder: (_) => FlareGiffyDialog(
  //   flarePath: 'assets/space_demo.flr',
  //   flareAnimation: 'loading',
  //   title: const Text('Space Reloading',
  //          style: TextStyle(
  //          fontSize: 22.0, fontWeight: FontWeight.w600),
  //   ),
  //   description: Text('This is a space reloading dialog box.
  //         This library helps you easily create fancy flare dialog.',
  //         textAlign: TextAlign.center,
  //         style: TextStyle(),
  //       ),
  //   entryAnimation: EntryAnimation.DEFAULT,
  //   onOkButtonPressed: () {},
  // )
  //   buttons: [
  //     DialogButton(
  //       child: Text(
  //         "CENCEL",
  //         style: TextStyle(color: Colors.white, fontSize: 20),
  //       ),
  //       onPressed: () => Navigator.pop(context),
  //       color: Color.fromRGBO(0, 179, 134, 1.0),
  //     ),
  //     DialogButton(
  //       child: Text(
  //         "CONFIRM",
  //         style: TextStyle(color: Colors.white, fontSize: 20),
  //       ),
  //       onPressed: () => Navigator.pop(context),
  //       gradient: LinearGradient(colors: [
  //         Color.fromRGBO(116, 116, 191, 1.0),
  //         Color.fromRGBO(52, 138, 199, 1.0)
  //       ]),
  //     )
  //   ],
  // ).


  // dialogConfirm3() {
  //   showDialog(
  //       context: context,
  //       builder: (_) => NetworkGiffyDialog(
  //             image: Image.network(
  //               "https://raw.githubusercontent.com/Shashank02051997/FancyGifDialog-Android/master/GIF's/gif14.gif",
  //               fit: BoxFit.cover,
  //             ),
  //             title: const Text('Confirm',
  //                 textAlign: TextAlign.center,
  //                 style:
  //                     TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600)),
  //             description: const Text(
  //               'Thank You',
  //               textAlign: TextAlign.center,
  //             ),
  //             entryAnimation: EntryAnimation.DEFAULT,
  //             onOkButtonPressed: () {},
  //           ));
  // }