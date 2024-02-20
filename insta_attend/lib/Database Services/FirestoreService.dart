import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Stream<QuerySnapshot> getEmployeeDetails() {
    return _firestore.collection('employeeDetails').snapshots();
  }

  static Stream<QuerySnapshot> getActiveEmployees() {
    return _firestore
        .collection('employeeDetails')
        .where('isEnrolled', isEqualTo: true)
        .snapshots();
  }

  static Stream<QuerySnapshot> getInActiveEmployees(){
    return _firestore
        .collection('employeeDetails')
        .where('isEnrolled', isEqualTo: false)
        .snapshots();
  }

  static Future<void> updateEnrollment(String employeeId, bool isEnrolled) async {
    try {
      await _firestore.collection('employeeDetails').doc(employeeId).update({
        'isEnrolled': isEnrolled,
      });
      print('Enrollment updated successfully for $employeeId.');
    } catch (error) {
      print('Error updating enrollment: $error');
    }
  }
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
                    FirebaseAuth.instance.currentUser?.delete();
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

  static Future<void> _updateEnrollment(String employeeId, bool isEnrolled) async {
    try {
      await _firestore.collection('employeeDetails').doc(employeeId).update({
        'isEnrolled': isEnrolled,
      });
      print('Enrollment updated successfully for $employeeId.');
    } catch (error) {
      print('Error updating enrollment: $error');
    }
  }

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
                      FirebaseService.updateEnrollment(employeeId, !isEnrolled);
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

  static Future<void> updateGeoFencing(String employeeId, bool geoFencing) async {
    try {
      await _firestore.collection('employeeDetails').doc(employeeId).update({
        'geoFencing': geoFencing,
      });
      print('Geofencing updated successfully for $employeeId.');
    } catch (error) {
      print('Error updating: $error');
    }
  }
}