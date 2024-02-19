import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Database Services/FirestoreService.dart';
import '../../configurations/CardTextStyle.dart';
import '../Widget/Animations/Loading.dart';

class activeEmployeeCard extends StatefulWidget {
  const activeEmployeeCard({super.key});

  @override
  State<activeEmployeeCard> createState() => _activeEmployeeCardState();
}

class _activeEmployeeCardState extends State<activeEmployeeCard> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.comment,
                    size: 20.0,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Text(
                    "Active Employees",
                    style: CardTextStyle.titleMobileStyle,
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseService.getActiveEmployees(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return LoadingAnimation();
                  }

                  final activeEmployees = snapshot.data!.docs.length;

                  return Text(
                    '$activeEmployees Active Employees',
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
