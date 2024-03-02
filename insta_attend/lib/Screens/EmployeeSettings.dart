import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insta_attend/Database%20Services/FirestoreService.dart';
import 'package:insta_attend/Widget/Animations/Loading.dart';
import 'package:insta_attend/Widget/editEmployeeDetails.dart';

/******** Class to edit employee details ********/

class EmployeeSetting extends StatefulWidget {
  const EmployeeSetting({Key? key});

  @override
  State<EmployeeSetting> createState() => _EmployeeSettingState();
}

class _EmployeeSettingState extends State<EmployeeSetting> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('employeeDetails').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: LoadingAnimation());
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        final documents = snapshot.data!.docs;

        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                width: 300,
                child: Card(
                  child: ListTile(
                    title: Text(
                      "Employee",
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("Settings"),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  final employeeData = documents[index].data() as Map<String, dynamic>?;
                  final employeeId = documents[index].id;
                  final employeeName = employeeData?['username'] as String?;
                  final employeeEmail = employeeData?['email'] as String?;
                  final employeePhone = employeeData?['phoneNumber'] as String?;
                  final isEnrolled = employeeData?['isEnrolled'] as bool?;
                  final geoFencing = employeeData?['geoFencing'] as bool?;
              
                  if (employeeName == null
                      || isEnrolled == null
                      || geoFencing == null
                      || employeePhone == null
                      || employeeEmail == null) {
                    return SizedBox.shrink();
                  }
              
                  return Container(
                    width: 600,
                    margin: EdgeInsets.all(8.0),
                    padding: EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 8.0
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.purple.shade50
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          employeeName,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    isEnrolled ? Icons.check_box : Icons.check_box_outline_blank,
                                    color: Colors.green,
                                  ),
                                  onPressed: () => FirebaseService.updateEnrollment(
                                    employeeId,
                                    !isEnrolled,
                                    context
                                  ),
                                ),
                              ],
                            ),
                            Text("Enrollment")
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    geoFencing ? Icons.check_box : Icons.check_box_outline_blank,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () => FirebaseService.updateGeoFencing(
                                    employeeId,
                                    !geoFencing,
                                    context
                                  ),
                                ),
                              ],
                            ),
                            Text("Geofencing")
                          ],
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        IconButton(onPressed: (){
                          editEmployeeDetail(employeeId, context);
                        }, icon: Icon(Icons.edit)),
                        SizedBox(
                          width: 30,
                        ),
                        IconButton(onPressed: (){
                          FirebaseService.deleteEmployee(employeeId, context);
                        }, icon: Icon(Icons.delete, color: Colors.red,)
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
