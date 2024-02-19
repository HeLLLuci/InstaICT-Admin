import 'package:flutter/material.dart';
import 'package:insta_attend/Widget/Navigation/WebNavigation.dart';
import 'package:insta_attend/Widget/Navigation/mobileNavigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return (screenWidth < 1340) ? mobileNavigation() : WebNavigation();
  }
}
