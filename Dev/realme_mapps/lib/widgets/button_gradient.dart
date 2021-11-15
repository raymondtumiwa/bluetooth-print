import 'package:flutter/material.dart';
//import 'package:realme_mapps/constant.dart';

class ButtonGradient extends StatelessWidget {
  const ButtonGradient({
    Key key,
    @required this.title,
    //@required this.image,
    this.size = 60,
  }) : super(key: key);

  final String title;
  //final String image;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500.0,
      height: 50.0,
      //children: <Widget>[
      child: OutlineButton(
        shape: StadiumBorder(),
        textColor: Colors.blue,
        child: Text(title),
        borderSide:
            BorderSide(color: Colors.blue, style: BorderStyle.solid, width: 1),
        onPressed: () {},
      ),
      /*
        Image(
          height: size,
          image: AssetImage(image),
        ),
        */
      //SizedBox(height: 5),
      /*
        Text(title, style: kBlackRegularSmall.copyWith(fontSize: 15)),
        */
      //],
    );
  }
}
