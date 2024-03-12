import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/******** Future function to edit employee Details ********/

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

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
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
              Text("Employment Type:"),
              DropdownButtonFormField<String>(
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
              SizedBox(height: 10),
              ElevatedButton(
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

                  Map<String, dynamic> updateData = {
                    'username': username,
                    'phoneNumber': phoneNumber,
                    'Circle': employeeData['Circle'],
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
