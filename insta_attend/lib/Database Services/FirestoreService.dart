import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /********** Method to fetch number of total employees(Active, Inactive) ***********/

  static Stream<QuerySnapshot> getEmployeeDetails() {
    return _firestore.collection('employeeDetails').snapshots();
  }

  /********** Method to fetch active employee *********/

  static Stream<QuerySnapshot> getActiveEmployees() {
    return _firestore
        .collection('employeeDetails')
        .where('isEnrolled', isEqualTo: true)
        .snapshots();
  }

  /********** Method to fetch in-active employee *********/

  static Stream<QuerySnapshot> getInActiveEmployees(){
    return _firestore
        .collection('employeeDetails')
        .where('isEnrolled', isEqualTo: false)
        .snapshots();
  }

  /********** Method to update Enrollment *********/

  static Future<void> updateEnrollment(String employeeId, bool isEnrolled, BuildContext context) async {
    try {
      await _firestore.collection('employeeDetails').doc(employeeId).update({
        'isEnrolled': isEnrolled,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Enrollment updated')),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update')),
      );
    }
  }

  /********** Method to delete employee *********/

  static Future<void> deleteEmployee(String employeeId, BuildContext context) async {
    await showDialog(context: context, builder: (context) => AlertDialog(
      title: Text("Think twice"),
      content: Container(
        height: 70,
        child: Column(
          children: [
            Text("Are you sure you want to delete this user?"),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: (){
                  try {
                    FirebaseFirestore.instance
                        .collection('employeeDetails')
                        .doc(employeeId)
                        .delete();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Employee Deleted Successfully')),
                    );
                    Navigator.of(context).pop();
                  } catch (error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Employee not deleted: $error')),
                    );
                    Navigator.of(context).pop();
                  }
                }, child: Text("Delete")
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(onPressed: (){
                  Navigator.of(context).pop();
                }, child: Text("Keep him"))
              ],
            )
          ],
        ),
      ),
    ));
  }

  /********** Method to update employee details *********/

  static Future<void> showPopUp(String employeeId, bool isEnrolled, BuildContext context) async {
    try {
      final doc = await _firestore.collection('employeeDetails').doc(employeeId).get();
      final employeeData = doc.data() as Map<String, dynamic>;

      final username = employeeData['username'] as String?;
      final phoneNumber = employeeData['phoneNumber'] as String?;
      final email = employeeData['email'] as String?;
      if (username == null || phoneNumber == null || email == null) {
        return;
      }
      showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              title: Text("Employee Information"),
              content: Container(
                height: 130,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Employee Name: $username"),
                    SizedBox(height: 10,),
                    Text("Phone Number: $phoneNumber"),
                    SizedBox(height: 10,),
                    Text("Email ID: $email"),
                    SizedBox(height: 10,),
                    ElevatedButton(onPressed: (){
                      FirebaseService.updateEnrollment(employeeId, !isEnrolled, context);
                      Navigator.of(context).pop();
                    }, child: Text("Enroll"))
                  ],
                ),
              ),
            );
          }
      );
    } catch (error) {
      print('Error getting employee details: $error');
    }
  }

  /********** Method to update geo-fencing *********/

  static Future<void> updateGeoFencing(String employeeId, bool geoFencing, BuildContext context) async {
    try {
      await _firestore.collection('employeeDetails').doc(employeeId).update({
        'geoFencing': geoFencing,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Geo Fencing updated successfully")),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to update geoFencing")),
      );
    }
  }
}