import 'package:flutter/material.dart';

// Define a custom Form widget.
class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _AboutUsState extends State<AboutUs> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final versionText = Text(
      "System Management Engineering",
      style: TextStyle(color: Colors.grey[600], fontSize: 20),
      textAlign: TextAlign.center,
    );
    final versionText2 = Text(
      "PT Karunia Berlian Makmur",
      style: TextStyle(color: Colors.grey[600], fontSize: 15),
      textAlign: TextAlign.center,
    );
    final versionText4 = Text(
      "Incorporated with\n PT Onindonesia Sistem Teknologi",
      style: TextStyle(color: Colors.grey[600], fontSize: 15),
      textAlign: TextAlign.center,
    );
    final versionText3 = Text(
      "Team member\n Sidik Aulia Rahman\n Kevin Wiguna\n Kamaludin",
      style: TextStyle(color: Colors.grey[600], fontSize: 15),
      textAlign: TextAlign.center,
    );
    final versionText5 = Text(
      "Version 0.1 (March 2021)",
      style: TextStyle(color: Colors.grey[600], fontSize: 15),
      textAlign: TextAlign.center,
    );
    return Scaffold(
      backgroundColor: Color(0xFFFFC914),
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Center(
        child: ListView(
          //shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            Hero(
              tag: 'hero',
              child: CircleAvatar(
                backgroundColor: Color(0xFFFFC914),
                radius: 88.0,
                child: Image.asset('assets/icons/appicon.png'),
              ),
            ),
            SizedBox(height: 10.0),
            versionText,
            SizedBox(height: 15.0),
            versionText2,
            SizedBox(height: 15.0),
            versionText3,
            SizedBox(height: 15.0),
            versionText4,
            SizedBox(height: 180.0),
            versionText5
          ],
        ),
      ),
    );
  }
}
