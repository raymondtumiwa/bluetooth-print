import 'package:flutter/material.dart';
import 'package:realme_mapps/screens/main_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:realme_mapps/services/on_rest.dart';
import 'package:realme_mapps/services/on_shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String _accessToken;
//dialog
  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Login failed"),
          content: Text("Kesalahan username/password"),
          actions: <Widget>[
            FlatButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

//end dialog
  void savePreference(
      username, employeeRole, employeeArea, accessTokens, fcmToken) {
    OnRest.instance.registerFcm(username, fcmToken, accessTokens);
    OnSharedPreferences.instance.setStringValue('accessToken', accessTokens);
    OnSharedPreferences.instance.setStringValue('username', username);
    OnSharedPreferences.instance.setStringValue('employeeRole', employeeRole);
    OnSharedPreferences.instance.setStringValue('employeeArea', employeeArea);
  }

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Color(0xFFFFC914),
        radius: 48.0,
        child: Image.asset('assets/icons/appicon.png'),
      ),
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      controller: emailController,
      //style: TextStyle(color: Colors.white),
      //initialValue: '',
      decoration: InputDecoration(
        //fillColor: Colors.white,
        hintText: 'Username',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      controller: passwordController,
      //initialValue: 'some password',
      obscureText: true,
      decoration: InputDecoration(
        fillColor: Colors.white,
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

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

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        //borderRadius: BorderRadius.circular(30.0),
        //shadowColor: Colors.lightBlueAccent.shade100,
        //elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () async {
            if ((emailController.text != "") &&
                (passwordController.text != "")) {
              print("Not Null");
              //var testdrive = await OnRest.instance.loginApp(emailController.text, passwordController.text);
              OnRest.instance
                  .loginApp(emailController.text, passwordController.text)
                  .then((testdrive) => setState(() {
                        if (testdrive != 'error') {
                          OnSharedPreferences.instance
                              .getStringValue('fcmtoken')
                              .then((val) => {
                                    savePreference(
                                        testdrive['username'],
                                        testdrive['roles'],
                                        testdrive['employeeArea'],
                                        testdrive['accessToken'],
                                        val)
                                  });

                          Navigator.of(context).pushReplacementNamed(
                            'main_screen',
                            //arguments: emailController
                          );
                        } else {
                          _showDialog();
                        }
                      }));
            } else {
              _showDialog();
            }
          },
          color: Colors.lightBlueAccent,
          child: Text('Log In', style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Color(0xFFFFC914),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            loginButton,
            SizedBox(height: 24.0),
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
