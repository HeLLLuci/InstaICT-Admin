import 'package:flutter/material.dart';
import 'package:insta_attend/Screens/Circle.dart';
import 'package:insta_attend/Screens/accountDeleteRequest.dart';
import 'package:insta_attend/Screens/changeAttendance.dart';
import '../../Screens/Homepage.dart';
import '../../Screens/AttendanceDetails.dart';
import '../../Screens/EmployeeDetails.dart';
import '../../Screens/EmployeeSettings.dart';
import '../../Screens/EnrollmentRequest.dart';

/******** Web Navigation for Web screens********/


class WebNavigation extends StatefulWidget {
  const WebNavigation({super.key});

  @override
  State<WebNavigation> createState() => _WebNavigationState();
}

class _WebNavigationState extends State<WebNavigation> {
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
    addCircle(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // For Laptop Screen
      drawer: Drawer(),
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
      body: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: NavigationRail(
              onDestinationSelected: (int index){
                setState(() {
                  _selectedIndex = index;
                });
              },
              extended: isExpanded,
              backgroundColor: Colors.transparent,
              unselectedIconTheme: IconThemeData(
                  color: Colors.white, opacity: 1
              ),
              unselectedLabelTextStyle: TextStyle(
                color: Colors.white,
              ),
              selectedIconTheme:
              IconThemeData(color: Colors.deepPurple.shade900),
              destinations: [
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text("Home"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.people_alt),
                  label: Text("Employee Details"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.calendar_month),
                  label: Text("Attendance Details"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.person_add_alt_1),
                  label: Text("Settings"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.done_all),
                  label: Text("Enrollment Status"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.edit_calendar_outlined),
                  label: Text("Change Attendance Record"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.delete_outline_rounded),
                  label: Text("Requests for Delete Account"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.location_on),
                  label: Text("Circle section"),
                ),
              ],
              selectedIndex: _selectedIndex,
            ),
          ),
          IconButton(onPressed: (){
            setState(() {
              isExpanded = !isExpanded;
            });
          }, icon: isExpanded ? Icon(Icons.close) : Icon(Icons.arrow_forward_ios_outlined)),
          Expanded(child: _screens[_selectedIndex]),
        ],
      ),
    );
  }
}
