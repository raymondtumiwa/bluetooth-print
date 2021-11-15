import 'package:flutter/material.dart';
import 'package:my_app/home_screen.dart';
import 'package:my_app/pages/delivery.dart';
import 'package:my_app/pages/pickup.dart';
import 'package:my_app/pages/splash.dart';
import 'package:my_app/pages/test.dart';
import 'package:my_app/user/login.dart';
import 'package:my_app/user/sign_up.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, cameras}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/signup': (context) => const SignUp(),
        '/login': (context) => LoginPage(),
        '/main': (context) => const HomeScreen(),
        '/pickup': (context) => PickUp(),
        '/delivery': (context) => DeliveryPage(),
        '/test': (context) => const TestPage(),
        '/splash': (context) => SplashScreen(),

        // '/details': (context) => DetailsPage(),
        // '/confirm': (context) => Confirm(),
      },
      initialRoute: '/splash',
    );
  }
}
