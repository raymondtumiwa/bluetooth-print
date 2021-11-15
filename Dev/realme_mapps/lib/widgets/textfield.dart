//import 'dart:ffi';

import 'package:flutter/material.dart';
//import 'package:realme_mapps/constant.dart';

class TextFieldStandard extends StatelessWidget {
  const TextFieldStandard({
    //@required this.icon,
    //this.iconActive,
    @required this.hintText,
    //this.isActive = false,
    //this.onTap,
    Key key,
  }) : super(key: key);

  final String hintText;
  //final IconData icon;
  //final IconData iconActive;
  //final Widget onTap;
  //final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 5.0),
        child: TextField(
          //minLines: 10,
          //maxLines: 15,
          autocorrect: false,
          decoration: InputDecoration(
            hintText: hintText,
            //filled: true,
            //fillColor: Color(0xFFDBEDFF),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
        ));
  }
}

class TextFieldSuffix extends StatelessWidget {
  const TextFieldSuffix({
    @required this.icon,
    //this.iconActive,
    @required this.hintText,
    //this.isActive = false,
    this.onPressed,
    Key key,
  }) : super(key: key);

  final String hintText;
  final IconData icon;
  //final IconData iconActive;
  final Function onPressed;
  //final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 5.0),
        child: TextField(
          //minLines: 10,
          //maxLines: 15,
          autocorrect: false,
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: IconButton(
              onPressed: onPressed,
              icon: Icon(icon),
            ),
            //filled: true,
            //fillColor: Color(0xFFDBEDFF),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
        ));
  }
}
