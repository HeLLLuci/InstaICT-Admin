import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<void> editEmployeeDetail(String employeeId, BuildContext context) async {
  try {
    final doc = await FirebaseFirestore.instance.collection('employeeDetails').doc(employeeId).get();
    final employeeData = doc.data() as Map<String, dynamic>;

    var username = employeeData['username'] as String?;
    var phoneNumber = employeeData['phoneNumber'] as String?;
    final email = employeeData['email'] as String?;
    if (username == null || phoneNumber == null || email == null) {
      return;
    }

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Employee Details"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Employee Name:"),
              TextFormField(
                initialValue: username,
                decoration: InputDecoration(hintText: 'Enter new name'),
                onChanged: (value) => username = value,
              ),
              SizedBox(height: 10),
              Text("Phone Number:"),
              TextFormField(
                initialValue: phoneNumber,
                decoration: InputDecoration(hintText: 'Enter new phone number'),
                onChanged: (value) => phoneNumber = value,
              ),
              SizedBox(height: 10),
              Text("Employee Type:"),
              DropdownButtonFormField<String>(
                value: employeeData['employeeType'] as String?,
                items: <DropdownMenuItem<String>>[
                  DropdownMenuItem(
                    value: 'Corporate employee',
                    child: Text('Corporate employee'),
                  ),
                  DropdownMenuItem(
                    value: 'Field worker',
                    child: Text('Field worker'),
                  ),
                ],
                onChanged: (value) {
                  // Update employeeType in the employeeData map
                  employeeData['employeeType'] = value;
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  // Validate inputs before updating
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

                  // Create a new map for update
                  Map<String, dynamic> updateData = {
                    'username': username,
                    'phoneNumber': phoneNumber,
                    'employeeType': employeeData['employeeType'],
                  };

                  await FirebaseFirestore.instance
                      .collection('employeeDetails')
                      .doc(employeeId)
                      .update(updateData);

                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Employee details updated')),
                  );
                },
                child: Text("Update"),
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
