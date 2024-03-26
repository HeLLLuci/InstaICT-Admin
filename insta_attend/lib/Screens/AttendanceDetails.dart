import 'package:flutter/material.dart';
import 'package:insta_attend/configurations/CardTextStyle.dart';
import '../EmployeeData/Tables/employeeAttendanceTable.dart';

/******** Class to Attendance Details where i called attendance table ********/

class AttendanceDetails extends StatefulWidget {
  const AttendanceDetails({super.key});

  @override
  State<AttendanceDetails> createState() => _AttendanceDetailsState();
}

class _AttendanceDetailsState extends State<AttendanceDetails> {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: controllers.scrollController,
      scrollbarOrientation: ScrollbarOrientation.right,
      child: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          ListTile(
            title: Text("Attendance Details",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
              ),
            ),
            subtitle: Text("Attendance Record"),
          ),
          Divider(color: Colors.grey,height: 2,),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: employeeAttendanceTable(),
          )
        ],
      ),
    );
  }
}
