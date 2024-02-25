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
                  DropdownMenuItem(
                    value: 'MP (Madhyapradesh)',
                    child: Text('MP (Madhyapradesh)'),
                  ),
                  DropdownMenuItem(
                    value: 'UPW (UP West)',
                    child: Text('UPW UP West'),
                  ),
                  DropdownMenuItem(
                    value: 'UPE (UP East)',
                    child: Text('UPE UP East'),
                  ),
                  DropdownMenuItem(
                    value: 'RJ (Rajasthan)',
                    child: Text('RJ Rajasthan'),
                  ),
                  DropdownMenuItem(
                    value: 'GUJ (Gujarat)',
                    child: Text('GUJ Gujarat'),
                  ),
                  DropdownMenuItem(
                    value: 'MH (Maharashtra)',
                    child: Text('MH Maharashtra'),
                  ),
                  DropdownMenuItem(
                    value: 'Bihar',
                    child: Text('Bihar'),
                  ),
                  DropdownMenuItem(
                    value: 'ROB (Rest of Bengal)',
                    child: Text('ROB Rest of Bangal'),
                  ),
                  DropdownMenuItem(
                    value: 'KOL (Kolkata)',
                    child: Text('KOL Kolkata'),
                  ),
                  DropdownMenuItem(
                    value: 'PNB (Punjab)',
                    child: Text('PNB Punjab'),
                  ),
                  DropdownMenuItem(
                    value: 'HR (Haryana)',
                    child: Text('HR Haryana'),
                  ),
                  DropdownMenuItem(
                    value: 'AP (Andhra pradesh)',
                    child: Text('AP Andhra Pradesh'),
                  ),
                  DropdownMenuItem(
                    value: 'KTK (Karnataka)',
                    child: Text('KTK Karnataka'),
                  ),
                  DropdownMenuItem(
                    value: 'ROTN (Rest of Tamil Nadu)',
                    child: Text('ROTN Rest of Tamil Nadu'),
                  ),
                  DropdownMenuItem(
                    value: 'KE (Kerala)',
                    child: Text('KE Kerala'),
                  ),
                  DropdownMenuItem(
                    value: 'Chennai',
                    child: Text('Chennai'),
                  ),
                  DropdownMenuItem(
                    value: 'MUM (Mumbai)',
                    child: Text('MUM Mumbai'),
                  ),
                  DropdownMenuItem(
                    value: 'JH (Jharkhand)',
                    child: Text('JH Jharkhand'),
                  ),
                ],
                onChanged: (value) {
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