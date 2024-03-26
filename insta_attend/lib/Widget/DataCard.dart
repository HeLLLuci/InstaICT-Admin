import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../configurations/CardTextStyle.dart';
import 'Animations/Loading.dart';

class LaptopCard extends StatelessWidget {
  final Stream<QuerySnapshot<Object?>>? stream;
  final String cardTitle;
  const LaptopCard({super.key, required this.stream, required this.cardTitle});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cardTitle,
                style: CardTextStyle.titleMobileStyle,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: stream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return LoadingAnimation();
                  }
                  final activeEmployees = snapshot.data!.docs.length;
                  return Text(
                    '$activeEmployees $cardTitle',
                    style: CardTextStyle.subtitleTextStyle,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

