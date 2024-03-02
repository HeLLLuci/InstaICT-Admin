import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../Database Services/FirestoreService.dart';
import '../../configurations/CardTextStyle.dart';
import '../Widget/Animations/Loading.dart';

/******** Class to show in-active employee Card ********/

class inActiveEmployeeCard extends StatefulWidget {
  const inActiveEmployeeCard({super.key});
  @override
  State<inActiveEmployeeCard> createState() => _inActiveEmployeeCardState();
}

class _inActiveEmployeeCardState extends State<inActiveEmployeeCard> {
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
                    Icons.comments_disabled,
                    size: 20.0,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Text(
                    "In-active Employees",
                    style: CardTextStyle.titleMobileStyle,
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseService.getInActiveEmployees(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return LoadingAnimation();
                  }

                  final activeEmployees = snapshot.data!.docs.length;

                  return Text(
                    '$activeEmployees In-active Employees',
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
