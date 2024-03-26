import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../configurations/CardTextStyle.dart';
import 'Animations/Loading.dart';

class MobileCard extends StatelessWidget {
  final Stream<QuerySnapshot<Object?>>? stream;
  final String cardTitle;
  const MobileCard({super.key, required this.stream, required this.cardTitle});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(8.0),
      width: 800,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.purple.shade50
      ),
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
                style: screenWidth > 500 ? TextStyle(
                  color: Colors.black,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ) : TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                )
              );
            },
          ),
        ],
      ),
    );
  }
}