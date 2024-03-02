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

    return Container(
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://mighty.tools/mockmind-api/content/human/57.jpg"),
                      radius: 20.0,
                    ),
                    margin: EdgeInsets.all(10.0),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  (screenWidth < 1250) ? CardCarousel() : CardDetails(),
                  SizedBox(
                    height: 30.0,
                  ),

                  screenWidth > 1250 ? WebHomeContent() : MobileHomeContent()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
