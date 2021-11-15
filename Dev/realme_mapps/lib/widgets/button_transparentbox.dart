//import 'dart:ffi';

import 'package:flutter/material.dart';
//import 'package:realme_mapps/constant.dart';

class ButtonTransparentBox extends StatelessWidget {
  const ButtonTransparentBox({
    //@required this.icon,
    //this.iconActive,
    @required this.title,
    //this.isActive = false,
    this.onTap,
    Key key,
  }) : super(key: key);

  final String title;
  //final IconData icon;
  //final IconData iconActive;
  final Widget onTap;
  //final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 5.0),
        child: FlatButton(
          minWidth: double.infinity,
          height: 50,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: BorderSide(color: Colors.blue)),
          color: Colors.white,
          textColor: Colors.blue,
          padding: EdgeInsets.all(8.0),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => onTap));
          },
          child: Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
        ));
  }
}

class ButtonTransparentBoxNormal extends StatelessWidget {
  const ButtonTransparentBoxNormal({
    //@required this.icon,
    //this.iconActive,
    @required this.title,
    //this.isActive = false,
    this.onPressed,
    Key key,
  }) : super(key: key);

  final String title;
  //final IconData icon;
  //final IconData iconActive;
  final Function onPressed;
  //final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 5.0),
        child: FlatButton(
          minWidth: double.infinity,
          height: 50,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: BorderSide(color: Colors.blue)),
          color: Colors.white,
          textColor: Colors.blue,
          padding: EdgeInsets.all(8.0),
          onPressed: onPressed,
          child: Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
        ));
  }
}
