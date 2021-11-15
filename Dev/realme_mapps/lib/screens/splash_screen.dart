import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:realme_mapps/screens/login_screen.dart';
//import 'package:onapps/screens/homescreen.dart';
import 'package:realme_mapps/screens/main_screen.dart';
//import 'package:onapps/widgets/grab_logo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:realme_mapps/services/on_shared_preferences.dart';
import 'package:realme_mapps/services/on_rest.dart';

class SplashScreen extends StatefulWidget {
  static const String id = "splash_screen";
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer _timer;
  String _homeScreenText = "Waiting for token...";
  String _messageText = "Waiting for message...";
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String fcmToken;

/*
  retrieveToken() async {
    final prefs = await SharedPreferences.getInstance();
    bool checkValue = prefs.containsKey('accessToken');
    final tokens = prefs.getString('accessToken') ?? 0;
    print(tokens);
    print("Check Val " + checkValue.toString());
    return (tokens);
  }
*/
  retrieveToken() async {
    final prefs = await SharedPreferences.getInstance();
    bool checkValue = prefs.containsKey('accessToken');
    final tokens = prefs.getString('accessToken') ?? 0;
    print(tokens);
    print("Check Val " + checkValue.toString());
    return (tokens);
  }

  removeScreen() {
    return _timer = Timer(Duration(seconds: 5), () {
      //var verify = retrieveToken();
      var verify;
      OnSharedPreferences.instance
          .getStringValue("username")
          .then((username) => setState(() {
                OnSharedPreferences.instance
                    .getStringValue("accessToken")
                    .then((value) => setState(() {
                          verify = value;
                          //print("say it");
                          if ((verify == "") || (verify == "")) {
                            print("no tokens");
                            Navigator.of(context)
                                .pushReplacementNamed(LoginScreen.id);
                          } else {
                            print("verify");
                            OnRest.instance
                                .verifyAccessTokens(username, verify)
                                .then((testdrive) {
                              if (testdrive != 'error') {
                                print(verify);
                                var username = OnSharedPreferences.instance
                                    .getStringValue('username')
                                    .toString();
                                OnRest.instance
                                    .registerFcm(username, fcmToken, verify);
                                Navigator.of(context)
                                    .pushReplacementNamed(MainScreen.id);
                              } else {
                                print(verify);
                                Navigator.of(context)
                                    .pushReplacementNamed(LoginScreen.id);
                              }
                            }).catchError((onError) {
                              print("conn erro");
                              Navigator.of(context)
                                  .pushReplacementNamed(LoginScreen.id);
                            });
                          }
                        }));
              }));
    });
  }

  @override
  void initState() {
    super.initState();
    //firebase start
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        setState(() {
          _messageText = "Push Messaging message: $message";
        });
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        setState(() {
          _messageText = "Push Messaging message: $message";
        });
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        setState(() {
          _messageText = "Push Messaging message: $message";
        });
        print("onResume: $message");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      setState(() {
        _homeScreenText = "Push Messaging token: $token";
      });
      print(_homeScreenText);
      OnSharedPreferences.instance.setStringValue('fcmtoken', token.toString());
      fcmToken = token.toString();
      print(fcmToken);
    });
    //firebase end
    //retrieveToken();
    removeScreen();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /*
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/login-register.jpg"),
            fit: BoxFit.cover),
      ),
      child: Center(child: FlutterLogo(size: 300)),
    );
    */
    final versionText = Text(
      "System Management Engineering",
      style: TextStyle(color: Colors.grey[600], fontSize: 15),
      textAlign: TextAlign.center,
    );
    final versionText2 = Text(
      "PT Karunia Berlian Makmur",
      style: TextStyle(color: Colors.grey[600], fontSize: 15),
      textAlign: TextAlign.center,
    );
    final versionText3 = Text(
      "Version 0.1 (March 2021)",
      style: TextStyle(color: Colors.grey[600], fontSize: 15),
      textAlign: TextAlign.center,
    );

    return Scaffold(
      backgroundColor: Color(0xFFFFC914),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            Image(
              width: 150,
              //color: Color(0xFF1254A0),
              image: AssetImage(
                "assets/icons/appicon.png",
              ),
            ),
            SizedBox(height: 64.0),
            versionText,
            SizedBox(height: 8.0),
            versionText2,
            SizedBox(height: 8.0),
            versionText3
          ],
        ),
      ),
    );
  }
}
