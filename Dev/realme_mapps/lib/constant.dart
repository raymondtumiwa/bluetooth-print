import 'package:flutter/material.dart';

const kWhiteBoldMedium = TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.bold,
  fontFamily: 'Sanomat Grab Web',
  color: Colors.white,
);

const kWhiteRegularSmall = TextStyle(
  fontSize: 20,
  fontFamily: 'Sanomat Grab Web',
  color: Colors.white,
);

const kBlackBoldSmall = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.bold,
  fontFamily: 'Sanomat Grab Web',
  color: Colors.black,
);

const kBlackBoldMedium = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  fontFamily: 'Sanomat Grab Web',
  color: Colors.black,
);

const kBlackBoldLarge = TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.bold,
  fontFamily: 'Sanomat Grab Web',
  color: Colors.black,
);

const kBlackRegularMedium = TextStyle(
  fontSize: 20,
  fontFamily: 'Sanomat Grab Web',
  color: Colors.black,
);

const kBlackRegularSmall = TextStyle(
  fontSize: 12,
  fontFamily: 'Sanomat Grab Web',
  color: Colors.black,
);

fivePercentWidth(BuildContext context) {
  return MediaQuery.of(context).size.width * 0.05;
}

percentHeight(BuildContext context, double percent) {
  return MediaQuery.of(context).size.height * percent;
}
