import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:blue/services/onrest.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/globals.dart' as globals;

// import 'package:flutter_application_1/services/onrest.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {});
    // _getCurrentLocation();
    OnRest.instance.getAppVersion().then((value) => setState(() {
          print(value);
          var newValue = jsonDecode(value);
          version = newValue["version"].toString();
          link = newValue["link"];

          print("App Version : $version");
          print(version);
          print(link);

          if (releaseVersion == version) {
            print("jadi");
            print(globals.token);
            _prefs.then((SharedPreferences prefs) async {
              globals.token = prefs.getString("token") ?? "";
              print('HELOOOOOOOOO');
              print(globals.token);
              if (globals.token != "") {
                print("jadi disini");

                OnRest.instance.checkSesion().then((value) {
                  print(value);
                  setState(() {
                    globals.agentLocId = value['location_agent'];
                    globals.courierId = value['agent_id'];
                  });
                  Navigator.of(context).pushReplacementNamed('/main');
                }).catchError((e) {
                  Navigator.of(context).pushReplacementNamed('/login');
                });
              } else {
                print("nd jadi");
                Navigator.of(context).pushReplacementNamed('/login');
              }
            });
          } else {
            changeVersion();
            // Navigator.of(context).pushReplacementNamed('/login');
          }
        }));

    // startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
            child: Image(
                width: 200, image: AssetImage("assets/images/onapps.png"))));
  }

  var releaseVersion = "1.0.0";
  var version;
  var link;

  void changeVersion() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("WARNING"),
          content: const Text(
              "Versi terbaru sudah rilis! Silahkan download aplikasi dengan update terbaru"),
          actions: <Widget>[
            FlatButton(
              child: const Text("Update"),
              onPressed: () {
                // launch(link);
                exit(0);
              },
            ),
          ],
        );
      },
    );
  }
}
