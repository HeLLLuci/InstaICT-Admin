import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insta_attend/Database%20Services/FirestoreService.dart';
import 'package:insta_attend/Widget/Animations/Loading.dart';
import 'package:insta_attend/Widget/editEmployeeDetails.dart';

class EmployeeSetting extends StatefulWidget {
  const EmployeeSetting({Key? key});

  @override
  State<EmployeeSetting> createState() => _EmployeeSettingState();
}

class _EmployeeSettingState extends State<EmployeeSetting> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      ListTile(
        title: Text(
          "Attendance Details",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          "Activate-Deactivate user, Geofencing, Change employee details",
        ),
      ),
      Divider(
        color: Colors.grey,
      ),
      SizedBox(
        height: 20,
      ),
      StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('employeeDetails').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: LoadingAnimation());
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          final documents = snapshot.data!.docs;

          if (documents.isEmpty) {
            return Center(child: Text('No data available.'));
          }

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: MaterialStateProperty.resolveWith(
                  (states) => Colors.grey.shade200),
              columns: [
                DataColumn(label: Text("Employee Name")),
                DataColumn(label: Text("Email")),
                DataColumn(label: Text("Phone Number")),
                DataColumn(label: Text("Activation")),
                DataColumn(label: Text("GeoFencing")),
                // DataColumn(label: Text("Admin Status")),
                DataColumn(label: Text("Actions")),
              ],
              rows: [
                for (var document in documents)
                  DataRow(
                    cells: [
                      DataCell(Text(document['username'] ?? '')),
                      DataCell(Text(document['email'] ?? '')),
                      DataCell(Text(document['phoneNumber'] ?? '')),
                      DataCell(
                        IconButton(
                          icon: Icon(
                            document['isEnrolled']
                                ? Icons.check_circle
                                : Icons.cancel,
                            color: document['isEnrolled']
                                ? Colors.green
                                : Colors.red,
                          ),
                          onPressed: () => FirebaseServices.updateEnrollment(
                            document.id,
                            !document['isEnrolled'],
                            context,
                          ),
                        ),
                      ),
                      DataCell(
                        IconButton(
                          icon: Icon(
                            document['geoFencing']
                                ? Icons.check_circle
                                : Icons.cancel,
                            color: document['geoFencing']
                                ? Colors.green
                                : Colors.red,
                          ),
                          onPressed: () => FirebaseServices.updateGeoFencing(
                            document.id,
                            !document['geoFencing'],
                            context,
                          ),
                        ),
                      ),
                      // DataCell(
                      //   IconButton(
                      //     icon: Icon(
                      //       document['isAdmin']
                      //           ? Icons.check_circle
                      //           : Icons.cancel,
                      //       color: document['isAdmin']
                      //           ? Colors.green
                      //           : Colors.red,
                      //     ),
                      //     onPressed: () => FirebaseServices.updateAdminStatus(
                      //       document.id,
                      //       !document['isAdmin'],
                      //       context,
                      //     ),
                      //   ),
                      // ),
                      DataCell(
                        Row(
                          children: [
                            IconButton(
                              onPressed: () =>
                                  editEmployeeDetail(document.id, context),
                              icon: Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () => FirebaseServices.deleteEmployee(
                                  document.id, context),
                              icon: Icon(Icons.delete, color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    ]);
  }
}
