import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insta_attend/configurations/CardTextStyle.dart';
import '../../Database Services/FirestoreService.dart';
import '../../EmployeeData/activeEmployeeCard.dart';
import '../../EmployeeData/inActiveEmployeeCard.dart';

/******** Class for card view in desktop screen ********/


class CardDetails extends StatelessWidget {
  const CardDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseService.getEmployeeDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        final totalEmployee = snapshot.data!.docs.length;
        return Container(
          padding: EdgeInsets.only(right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              detailCard(
                icon: Icons.people,
                title: "Total Employees",
                value: "$totalEmployee Employees",
              ),
              activeEmployeeCard(),
              inActiveEmployeeCard(),
            ],
          ),
        );
      },
    );
  }

  Widget detailCard({required IconData icon, required String title, required String value}) {
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
                    icon,
                    size: 20.0,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Text(
                    title,
                    style: CardTextStyle.titleMobileStyle,
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                value,
                style: CardTextStyle.subtitleTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }

}
