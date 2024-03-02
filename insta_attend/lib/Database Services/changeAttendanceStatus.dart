import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChangeAttendanceStatus {

  /**********  Method to update the attendance status  **********/

  static Future<void> showEditDialog(BuildContext context, DocumentSnapshot document) async {
    String selectedStatus = (document.data() as Map<String, dynamic>)['Status'] ?? '';
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Status'),
          content: Container(
            height: 150,
            child: Column(
              children: [
                DropdownButton<String>(
                  value: selectedStatus,
                  items: ['Present', 'Half-Day', 'Absent']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    selectedStatus = value!;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                updateStatus(document, selectedStatus);
                Navigator.of(context).pop();
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  /*********  Method that takes selected Item from dropdown and set it to database *********/

  static void updateStatus(DocumentSnapshot document, String selectedStatus) {
    FirebaseFirestore.instance.collection('attendance').doc(document.id).update({
      'Status': selectedStatus,
    });
  }
}
