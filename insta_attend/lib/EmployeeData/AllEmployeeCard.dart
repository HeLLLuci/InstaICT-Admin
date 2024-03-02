import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insta_attend/Widget/Animations/Loading.dart';

import '../../Database Services/FirestoreService.dart';
import '../../configurations/CardTextStyle.dart';

/******** Class to show all employee Card ********/

class AllEmployeeCard extends StatefulWidget {
  const AllEmployeeCard({super.key});

  @override
  State<AllEmployeeCard> createState() => _AllEmployeeCardState();
}

class _AllEmployeeCardState extends State<AllEmployeeCard> {
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
                    "Total Employees",
                    style: CardTextStyle.titleMobileStyle,
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseService.getEmployeeDetails(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return LoadingAnimation();
                  }

                  final activeEmployees = snapshot.data!.docs.length;

                  return Text(
                    '$activeEmployees Total Employees',
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
