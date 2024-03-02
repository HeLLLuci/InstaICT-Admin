import 'package:flutter/material.dart';
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
                child: employeeAttendanceTable(),
              )
            ],
          ),
    );
  }
}
