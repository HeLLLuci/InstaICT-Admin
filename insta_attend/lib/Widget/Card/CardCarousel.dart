import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:insta_attend/Widget/mobile_data_card.dart';
import 'package:insta_attend/Widget/mobile_data_card.dart';
import 'package:insta_attend/Widget/mobile_data_card.dart';
import '../../Database Services/FirestoreService.dart';
import '../DataCard.dart';

/******** Class carousel view in mobile screen ********/

class CardCarousel extends StatefulWidget {
  const CardCarousel({super.key});

  @override
  State<CardCarousel> createState() => _CardCarouselState();
}

class _CardCarouselState extends State<CardCarousel> {

  final List<Widget> _items = [
    MobileCard(stream: FirebaseServices.getEmployeeDetails(), cardTitle: 'Total Employee',),
    MobileCard(stream: FirebaseServices.getActiveEmployees(), cardTitle: 'Active Employee',),
    MobileCard(stream: FirebaseServices.getInActiveEmployees(), cardTitle: 'In-Active Employee',),
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: _items,
        options: CarouselOptions(
          height: 170,
          aspectRatio: 16/9,
          viewportFraction: 0.5,
          enableInfiniteScroll: false,
          reverse: false,
          autoPlay: true,
          initialPage: 1,
          enlargeCenterPage: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          scrollDirection: Axis.horizontal,
        )
    );
  }
}
