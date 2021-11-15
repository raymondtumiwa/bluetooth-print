import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:realme_mapps/screens/home/home_cctome.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:onapps/constant.dart';
import 'package:realme_mapps/screens/home/home_screen.dart';
import 'package:realme_mapps/screens/home/home_completed_task.dart';
import 'package:realme_mapps/widgets/bottom_navigation_item.dart';
import 'package:realme_mapps/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'about_us.dart';

var arr1 = [];

class MainScreen extends StatefulWidget {
  const MainScreen({
    this.test,
    Key key,
  }) : super(key: key);
  static const String id = 'main_screen';

  final test;
  @override
  _MainScreenState createState() => _MainScreenState();
}

removeToken() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove('accessToken');
}

class _MainScreenState extends State<MainScreen> {
  static ScrollController _hideButtonController;
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    HomeCcToMe(),
    HomeCompletedTask(),
    /*
    SafeArea(
      child: Text("Activity"),
    ),
    */
  ];

  bool _isVisible = true;
  @override
  void initState() {
    super.initState();
    //print(test);
    _isVisible = true;
    /*
    _hideButtonController = new ScrollController();
    _hideButtonController.addListener(() {
      if (_hideButtonController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() {
          _isVisible = false;
          print("**** $_isVisible up");
        });
      }
      if (_hideButtonController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {
          _isVisible = true;
          print("**** $_isVisible down");
        });
      }
    });
    */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: scaffoldKey,
      appBar: AppBar(
        title: Image.asset(
          'assets/images/onapps_text.png',
          fit: BoxFit.contain,
          height: 100,
        ),
        //centerTitle: true,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.memory),
            //tooltip: 'Show Messages',
            onPressed: () {
              //removeToken();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AboutUs()));
              //scaffoldKey.currentState.showSnackBar(snackBar);
            },
          ),
          IconButton(
            icon: const Icon(Icons.power_settings_new),
            //tooltip: 'Show Messages',
            onPressed: () {
              removeToken();
              Navigator.of(context).pushReplacementNamed(LoginScreen.id);
              //scaffoldKey.currentState.showSnackBar(snackBar);
            },
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                Color(0xFFFFC914),
                Color(0xFFFFC914),
              ])),
        ),
      ),

      bottomNavigationBar: AnimatedContainer(
        duration: Duration(milliseconds: 10),
        height:
            _isVisible ? MediaQuery.of(context).viewPadding.bottom + 70 : 0.0,
        child: BottomAppBar(
          elevation: 8,
          color: Colors.white,
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: BottomNavigationItem(
                    icon: Icons.near_me,
                    iconActive: Icons.near_me,
                    title: "To-do Task",
                    onTap: () {
                      _selectedIndex = 0;
                      setState(() {});
                    },
                    isActive: _selectedIndex == 0,
                  ),
                ),
                Expanded(
                  child: BottomNavigationItem(
                    icon: Icons.closed_caption,
                    iconActive: Icons.closed_caption_off,
                    title: "CC To Me",
                    onTap: () {
                      _selectedIndex = 1;
                      setState(() {});
                    },
                    isActive: _selectedIndex == 1,
                  ),
                ),
                Expanded(
                  child: BottomNavigationItem(
                    icon: Icons.check_circle,
                    iconActive: Icons.check_circle_outline,
                    title: "Completed Task",
                    onTap: () {
                      _selectedIndex = 2;
                      setState(() {});
                    },
                    isActive: _selectedIndex == 2,
                  ),
                ),
                /*
                Expanded(
                  child: BottomNavigationItem(
                    icon: Icons.person_pin,
                    title: "Anda",
                    onTap: () {
                      _selectedIndex = 2;
                      setState(() {});
                    },
                    isActive: _selectedIndex == 2,
                  ),
                ),
                */
                /*
                BottomNavigationItem(
                  icon: Icons.person_pin,
                  iconActive: Icons.person_pin,
                  title: "Account",
                  onTap: () {
                    _selectedIndex = 4;
                    setState(() {});
                  },
                  isActive: _selectedIndex == 4,
                ),
                */
              ],
            ),
          ),
        ),
      ),
      body: CustomScrollView(
        controller: _hideButtonController,
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return _widgetOptions.elementAt(_selectedIndex);
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}
