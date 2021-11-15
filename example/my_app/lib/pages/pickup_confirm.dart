import 'package:flutter/material.dart';
import 'package:my_app/pages/confirmed_pickup_details.dart';

class PickUpConfirmed extends StatefulWidget {
  @override
  _PickUpConfirmedState createState() => _PickUpConfirmedState();
}

class _PickUpConfirmedState extends State<PickUpConfirmed> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width * 0.8,
          child: MaterialButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ConfirmedPickUpDetail()));
            },
            child: Text('TESTSETSETS'),
          )),
    );
  }
}
