import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/services/custom_exception.dart';
import 'package:my_app/services/onrest.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:ondelivery_driver/services/custom_exception.dart';
// import 'package:ondelivery_driver/services/onrest.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import '../services/globals.dart' as globals;

class LoginPage extends StatefulWidget {
  static String id = 'login_screen';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = true;
  var usernameLogin;
  @override
  void initState() {
    super.initState();
    // initUniqueIdentifierState();
    // });
  }

  Future<void> _setToken(String token) async {
    final SharedPreferences prefs = await _prefs;

    setState(() {
      prefs.setString("token", token).then((bool success) {
        return;
      });
    });
  }
//dialog

  void dialogUserNotFound() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Login Gagal!"),
          content: Text("Username tidak terdaftar"),
          actions: <Widget>[
            FlatButton(
              child: Text("Coba Lagi"),
              onPressed: () {
                int count = 0;
                Navigator.popUntil(context, (route) {
                  return count++ == 2;
                });
              },
            ),
          ],
        );
      },
    );
  }

  void dialogPasswordSalah() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Login Gagal!"),
          content: Text("Password Salah!"),
          actions: <Widget>[
            FlatButton(
              child: Text("Coba Lagi"),
              onPressed: () {
                int count = 0;
                Navigator.popUntil(context, (route) {
                  return count++ == 2;
                });
              },
            ),
          ],
        );
      },
    );
  }

  dialogLoading() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => Center(
            child: Container(
                width: 150, height: 150, child: CircularProgressIndicator())));
  }

  void dialogGagal() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Login Gagal!"),
          content: Text("Username/Password Salah!"),
          actions: <Widget>[
            FlatButton(
              child: Text("Coba Lagi"),
              onPressed: () {
                int count = 0;
                Navigator.popUntil(context, (route) {
                  return count++ == 2;
                });
              },
            ),
          ],
        );
      },
    );
  }
//end dialog

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: Container(
        height: 180,
        // color: Colors.red,
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 48.0,
          child: Image.asset(
            'assets/logo.png',
          ),
        ),
      ),
    );

    final Shader lineargradient = const LinearGradient(colors: <Color>[
      Color(0xFF1254A0),
      Color(0xFF15bae8),
    ]).createShader(Rect.fromLTWH(0, 0, 200, 70));

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      controller: emailController,
      //initialValue: '',
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: 'Email',
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      // onChanged: (value) =>
      //     setState(() => this.passwordController = passwordController),
      // onFieldSubmitted: (value) =>
      //     setState(() => this.passwordController = passwordController),
      autofocus: false,
      controller: passwordController,
      //initialValue: 'some password',

      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: 'Password',
        // errorText: 'Salah password',
        suffixIcon: IconButton(
            icon: isPasswordVisible
                ? Icon(Icons.visibility_off)
                : Icon(Icons.visibility),
            onPressed: () =>
                setState(() => isPasswordVisible = !isPasswordVisible)),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      obscureText: isPasswordVisible,
    );

    Widget _buildSignUp() {
      return Padding(
        padding: const EdgeInsets.only(top: 15),
        child: RichText(
          text: TextSpan(
            //  style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              const TextSpan(
                text: "Belum memiliki Akun? ",
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    color: Colors.black),
              ),
              TextSpan(
                  text: 'Buat Akun',
                  style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Colors.blue,
                      fontSize: 14),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(builder: (context) => Attendance()),
                      //   );
                    }),
            ],
          ),
        ),
      );
    }

    // var namaEmployee;

    final loginButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    Color(0xFF15bae8),
                    Color(0xFF1254A0),
                  ])),
          child: MaterialButton(
            minWidth: 330.0,
            height: 42.0,
            onPressed: () {
              dialogLoading();
              OnRest.instance
                  .loginApp(emailController.text, passwordController.text)
                  .then((value) async {
                print(value);
                setState(() async {
                  globals.token = value['accessToken'];
                  globals.agentLocId = value['location_agent'];
                  globals.courierId = value['agentID'];
                  print(globals.agentLocId);
                  print(globals.courierId);
                  print("globals globalsglobals");
                  print(globals.token);
                  await _setToken(globals.token);
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/main', (Route<dynamic> route) => false);
                  // globals.username = value['username'];
                  // globals.driverId = value['id'];
                  // globals.driverName = value['name'];
                  // globals.token = value['accessToken'];
                });
                // await _setToken(globals.token);
              }).catchError((e) {
                if (e.runtimeType == UnauthorizedException) {
                  dialogGagal();
                }
              });
            },
            child: Text('Masuk', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );

    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipPath(
                  child: Container(
                    child: Column(),
                    width: double.infinity,
                    height: 300,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: <Color>[
                          Color(0xFF1254A0),
                          Color(0xFF15bae8),
                        ])),
                  ),
                ),
                ClipPath(
                  child: Container(
                    child: Column(),
                    width: double.infinity,
                    height: 300,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: <Color>[
                          Color(0xFF15bae8),
                          Color(0xFF1254A0),
                        ])),
                  ),
                ),
                ClipPath(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 40,
                        ),
                        // Image.asset(
                        //   'assets/images/car2.png',
                        //   height: 100,
                        // ),
                        const SizedBox(
                          height: 100,
                        ),
                        Center(
                          child: Text(
                            "COURIER APPS",
                            style: TextStyle(
                                foreground: Paint()..shader = lineargradient,
                                fontWeight: FontWeight.w700,
                                fontSize: 30),
                          ),
                        ),
                      ],
                    ),
                    width: double.infinity,
                    height: 300,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 320, 25, 30),
                  child: Material(
                    elevation: 2.0,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    child: email,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 390, 25, 30),
                  child: Material(
                    elevation: 2.0,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    child: password,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(60, 450, 50, 30),
                  child: Material(
                    child: loginButton,
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.fromLTRB(90, 530, 50, 30),
                //   child: Material(
                //     child: _buildSignUp(),
                //   ),
                // ),
                // Padding(
                //   padding: EdgeInsets.fromLTRB(120, 695, 25, 30),
                //   child: Container(
                //     child: Column(children: [
                //       Text(
                //         "Powered by OnIndonesia",
                //         style: TextStyle(color: Colors.black),
                //       )
                //     ]),
                //     //alignment: Alignment.bottomCenter,
                //     // child: Text(
                //     //   "Powered by OnIndonesia",
                //     //   style: TextStyle(color: Colors.white),
                //   ),
                // ),
              ],
            ),
          ],
        ));
  }
}
