import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../EmployeeData/AllEmployeeCard.dart';
import '../../EmployeeData/activeEmployeeCard.dart';
import '../../EmployeeData/inActiveEmployeeCard.dart';

/******** Class carousel view in mobile screen ********/

class CardCarousel extends StatefulWidget {
  const CardCarousel({super.key});

  @override
  State<CardCarousel> createState() => _CardCarouselState();
}

class _CardCarouselState extends State<CardCarousel> {

  final List<Widget> _items = [
    AllEmployeeCard(),
    activeEmployeeCard(),
    inActiveEmployeeCard()
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: _items,
        options: CarouselOptions(
          height: 200,
          aspectRatio: 16/9
    )
    );
  }
}
