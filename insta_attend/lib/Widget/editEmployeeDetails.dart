import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/******** Future function to edit employee Details ********/
class FirebaseService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
}

Future<void> editEmployeeDetail(String employeeId, BuildContext context) async {
  try {
    final doc = await FirebaseFirestore.instance.collection('employeeDetails').doc(employeeId).get();
    final circleDocs = await FirebaseFirestore.instance.collection('Circle').get();
    final employeeData = doc.data() as Map<String, dynamic>;
    var username = employeeData['username'] as String?;
    var phoneNumber = employeeData['phoneNumber'] as String?;
    final email = employeeData['email'] as String?;

    if (username == null || phoneNumber == null || email == null) {
      return;
    }

    List<String> circleDocumentIds = circleDocs.docs.map((doc) => doc.id).toList();

    bool geoFencing = employeeData['geoFencing'] ?? false;
    bool isEnrolled = employeeData['isEnrolled'] ?? false;
    bool isAdmin = employeeData['isAdmin'] ?? false;

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shadowColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Edit Employee Details"),
            IconButton(onPressed: () {
              Navigator.of(context).pop();
            }, icon: Icon(Icons.close))
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: username,
                decoration: InputDecoration(
                    labelText: "Employee Name",
                    border: OutlineInputBorder(),
                    hintText: 'Enter new name'),
                onChanged: (value) => username = value,
              ),
              SizedBox(height: 20),
              TextFormField(
                initialValue: phoneNumber,
                decoration: InputDecoration(
                    labelText: "Phone Number",
                    border: OutlineInputBorder(),
                    hintText: 'Enter new phone number'),
                onChanged: (value) => phoneNumber = value,
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                    labelText: "Employment Type",
                    border: OutlineInputBorder()
                ),
                value: employeeData['Circle'] as String?,
                items: circleDocumentIds.map((circleId) {
                  return DropdownMenuItem(
                    value: circleId,
                    child: Text(circleId),
                  );
                }).toList(),
                onChanged: (value) {
                  employeeData['Circle'] = value;
                },
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<bool>(
                decoration: InputDecoration(
                    labelText: "Enrollment",
                    border: OutlineInputBorder()
                ),
                value: isEnrolled,
                items: [
                  DropdownMenuItem(
                    value: true,
                    child: Text("Enroll"),
                  ),
                  DropdownMenuItem(
                    value: false,
                    child: Text("Block"),
                  ),
                ],
                onChanged: (value) {
                  isEnrolled = value ?? false;
                },
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<bool>(
                decoration: InputDecoration(
                    labelText: "Geo-Fencing",
                    border: OutlineInputBorder()
                ),
                value: geoFencing,
                items: [
                  DropdownMenuItem(
                    value: true,
                    child: Text("Enable"),
                  ),
                  DropdownMenuItem(
                    value: false,
                    child: Text("Disable"),
                  ),
                ],
                onChanged: (value) {
                  geoFencing = value ?? false;
                },
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<bool>(
                decoration: InputDecoration(
                    labelText: "Admin Privileges",
                    border: OutlineInputBorder()
                ),
                value: isAdmin,
                items: [
                  DropdownMenuItem(
                    value: true,
                    child: Text("Make Admin"),
                  ),
                  DropdownMenuItem(
                    value: false,
                    child: Text("Remove Admin Privilege"),
                  ),
                ],
                onChanged: (value) {
                  isAdmin = value ?? false;
                },
              ),
              SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (username == null || username!.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please enter a name')),
                      );
                      return;
                    }
                    if (phoneNumber == null || phoneNumber!.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please enter a phone number')),
                      );
                      return;
                    }
                    ArtSweetAlert.show(
                        context: context,
                        artDialogArgs: ArtDialogArgs(
                        type: ArtSweetAlertType.warning,
                        title: "Are you sure",
                        text: "Confirm all the details entered",
                        onConfirm: () async {
                      Map<String, dynamic> updateData = {
                        'username': username,
                        'phoneNumber': phoneNumber,
                        'Circle': employeeData['Circle'],
                        'geoFencing': geoFencing,
                        'isEnrolled': isEnrolled,
                        'isAdmin': isAdmin,
                      };
                      await FirebaseFirestore.instance
                          .collection('employeeDetails')
                          .doc(employeeId)
                          .set(updateData, SetOptions(merge: true));
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Employee details updated'),duration: Duration(seconds: 1)),

                      );
                    },
                    onCancel: (){
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    },
                    showCancelBtn: true,
                    confirmButtonColor: Colors.green,
                    confirmButtonText: "Update",
                    cancelButtonColor: Colors.red,
                    cancelButtonText: "Cancel"
                    )
                    );
                  },
                  child: Text("Update"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  } catch (error) {
    print('Error getting employee details: $error');
  }
}


