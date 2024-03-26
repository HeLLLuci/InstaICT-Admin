import 'package:flutter/material.dart';
import '../../Database Services/FirestoreService.dart';
import '../DataCard.dart';

/******** Class for card view in desktop screen ********/


class CardDetails extends StatelessWidget {
  const CardDetails({super.key});
  @override
  Widget build(BuildContext context) {
        return Row(
          children: [
            LaptopCard(stream: FirebaseServices.getEmployeeDetails(), cardTitle: 'Total Employee',),
            LaptopCard(stream: FirebaseServices.getActiveEmployees(), cardTitle: 'Active Employee',),
            LaptopCard(stream: FirebaseServices.getInActiveEmployees(), cardTitle: 'In-Active Employee',),
          ],
        );
  }
}
