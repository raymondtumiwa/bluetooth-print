import 'package:flutter/material.dart';
import 'package:realme_mapps/constant.dart';

class IconMenu extends StatelessWidget {
  const IconMenu({
    Key key,
    @required this.title,
    @required this.image,
    this.size = 60,
  }) : super(key: key);

  final String title;
  final String image;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image(
          height: size,
          image: AssetImage(image),
        ),
        SizedBox(height: 5),
        Text(title,
            textAlign: TextAlign.center,
            style: kBlackRegularSmall.copyWith(fontSize: 15)),
      ],
    );
  }
}
