import 'package:flutter/material.dart';
import '../EmployeeData/Tables/changeAttendanceTable.dart';

/******** Class to show change attendance screen ********/

class ChangeAttendance extends StatefulWidget {
  const ChangeAttendance({super.key});

  @override
  State<ChangeAttendance> createState() => _ChangeAttendanceState();
}

class _ChangeAttendanceState extends State<ChangeAttendance> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            width: 500,
            child: Card(
              child: ListTile(
                title: Text("Attendance Details",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                  ),
                ),
                subtitle: Text("Attendance Record"),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: changeAttendanceTable(),
          )
        ],
      ),
    );
  }
}
