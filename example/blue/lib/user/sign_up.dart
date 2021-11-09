// import 'package:flutter/material.dart';

// class LoginBody extends StatefulWidget {
//   const LoginBody({Key? key}) : super(key: key);

//   @override
//   _LoginBodyState createState() => _LoginBodyState();
// }

// class _LoginBodyState extends State<LoginBody> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//   }
// }
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Sign Up'),
            const TextField(
              decoration: InputDecoration(labelText: 'Username'),
            ),
            const TextField(
              decoration: InputDecoration(labelText: 'Email Address'),
            ),
            const TextField(
              decoration: InputDecoration(labelText: 'Password'),
            ),
            const TextField(
              decoration: InputDecoration(labelText: 'Confirm Password'),
            ),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text("Sign Up"),
            ),
            Container(
              width: 100,
              height: 50,
              color: Colors.transparent,
            )
          ],
        ),
      ),
    );
  }
}
