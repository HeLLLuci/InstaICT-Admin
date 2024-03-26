import 'package:flutter/material.dart';

/**********    Method to apply Title Text Style dynamically      *************/
class CardTextStyle{
  static TextStyle titleMobileStyle = TextStyle(
    color: Colors.black,
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
  );
  /***********   Method to apply Subtitle Text Style Dynamically       *************/

  static TextStyle subtitleTextStyle = TextStyle(
    color: Colors.black,
    fontSize: 36,
    fontWeight: FontWeight.bold,
  );
}

class DocNames{
  static String docName = "";
}

class controllers{
  static ScrollController scrollController = ScrollController();
}