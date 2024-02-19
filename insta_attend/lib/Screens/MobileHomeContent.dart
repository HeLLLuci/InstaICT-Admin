import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MobileHomeContent extends StatelessWidget {
  const MobileHomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Lottie.asset("assets/Lottie/dashboard.json")
      ],
    );
  }
}
