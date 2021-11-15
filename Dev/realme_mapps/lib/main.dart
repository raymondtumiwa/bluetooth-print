import 'package:flutter/material.dart';
import 'package:realme_mapps/screens/main_screen.dart';
//import 'package:onapps/screens/login_screen.dart';
import 'package:realme_mapps/screens/splash_screen.dart';
//import 'package:onapps/screens/verification_screen.dart';
import 'package:realme_mapps/screens/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Realme KBM Apps',
      theme: ThemeData(
        primaryColor: Color(0xFFFFC914),
      ),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        MainScreen.id: (context) => MainScreen(),
      },
    );
  }
}
