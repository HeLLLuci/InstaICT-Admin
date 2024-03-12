import 'package:flutter/material.dart';
import 'package:insta_attend/Screens/accountDeleteRequest.dart';
import 'package:insta_attend/Screens/changeAttendance.dart';

import '../../Screens/Homepage.dart';
import '../../Screens/AttendanceDetails.dart';
import '../../Screens/EmployeeDetails.dart';
import '../../Screens/EmployeeSettings.dart';
import '../../Screens/EnrollmentRequest.dart';

/******** Bottom Navigation bar for Mobile screens ********/

class mobileNavigation extends StatefulWidget {
  const mobileNavigation({super.key});

  @override
  State<mobileNavigation> createState() => _mobileNavigationState();
}

class _mobileNavigationState extends State<mobileNavigation> {

  bool isExpanded = false;
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    Home(),
    EmployeeDetails(),
    AttendanceDetails(),
    EmployeeSetting(),
    EnrollmentRequest(),
    ChangeAttendance(),
    DeleteRequest(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // For mobile Screen
      appBar:  AppBar(
        title: Text("Admin Dashboard",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leadingWidth: 80,
        leading: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Image.asset("assets/images/Insta logo.png", fit: BoxFit.cover,),
          margin: EdgeInsets.only(top: 5, left: 10),
          padding: EdgeInsets.all(5),
        ),
        backgroundColor: Color(0xFF4facfe),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 3,
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.blue,
        selectedItemColor: Colors.deepPurple.shade900,

        onTap: (int index){
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt),
            label: "Employee Details",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: "Attendance Details",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add_alt_1),
            label: "Employee Setting",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done_all),
            label: "Enrollment Request",
          ),BottomNavigationBarItem(
              icon: Icon(Icons.edit_calendar_outlined),
              label: "Change Attendance Record",
          ),BottomNavigationBarItem(
              icon: Icon(Icons.delete_outline_rounded),
              label: "Requests for Delete Account",
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: _screens[_selectedIndex]
          ),
        ],
      ),
    );
  }
}
