import 'package:flutter/material.dart';
import 'package:insta_attend/Screens/MobileHomeContent.dart';
import 'package:insta_attend/Widget/Card/CardCarousel.dart';
import 'package:insta_attend/Screens/WebHomeContent.dart';
import '../Widget/Card/CardDetails.dart';

/******** Class to show Homescreen ********/

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {

    final double screenWidth = MediaQuery.of(context).size.width;

    return ListView(
      children: [
        SizedBox(
          height: 20.0,
        ),
        (screenWidth < 950) ? CardCarousel() : CardDetails(),
        SizedBox(
          height: 30.0,
        ),

        screenWidth > 950 ? WebHomeContent() : MobileHomeContent()
      ],
    );
  }
}
