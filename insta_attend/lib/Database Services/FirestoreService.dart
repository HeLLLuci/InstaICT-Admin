import 'package:cloud_firestore/cloud_firestore.dart';

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
}