import 'package:flutter/material.dart';
import 'package:insta_attend/EmployeeData/Tables/employeeDetailTable.dart';
import 'package:insta_attend/configurations/CardTextStyle.dart';

/******** Class to show employee details table ********/

class EmployeeDetails extends StatefulWidget {
  const EmployeeDetails({super.key});
  @override
  State<EmployeeDetails> createState() => _EmployeeDetailsState();
}
class _EmployeeDetailsState extends State<EmployeeDetails> {
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: scrollController,
      children: [
        SizedBox(
          height: 20,
        ),
        ListTile(
          title: Text("Employee Details",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold
            ),
          ),
          subtitle: Text("Employee Record"),
        ),
        Divider(color: Colors.grey,),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: employeeDetailTable(),
        )
      ],
    );
  }
}
