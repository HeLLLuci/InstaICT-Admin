import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insta_attend/Database%20Services/FirestoreService.dart';
import 'package:insta_attend/configurations/CardTextStyle.dart';

class DeleteRequest extends StatefulWidget {
  const DeleteRequest({Key? key}) : super(key: key);
  @override
  State<DeleteRequest> createState() => _DeleteRequestState();
}

class _DeleteRequestState extends State<DeleteRequest> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('employeeDetails')
          .where('deletePermission', isEqualTo: "false")
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        final documents = snapshot.data!.docs;
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            ListTile(
              title: Text(
                "Account Delete Request",
                style: CardTextStyle.titleMobileStyle,
              ),
              subtitle: Text("Requests"),
            ),
            Divider(color: Colors.grey),
            SizedBox(height: 30),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor:
                MaterialStateProperty.resolveWith((states) => Colors.grey.shade200),
                columns: [
                  DataColumn(label: Text('Employee Name')),
                  DataColumn(label: Text('Employee Email')),
                  DataColumn(label: Text('Phone Number')),
                  DataColumn(label: Text('Requested type')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: documents.map<DataRow>((document) {
                  final employeeData = document.data() as Map<String, dynamic>;
                  final employeeId = document.id;
                  final employeeName = employeeData['username'] as String?;
                  final employeeEmail = employeeData['email'] as String?;
                  final employeePhone = employeeData['phoneNumber'] as String?;
                  final isEnrolled = employeeData['deletePermission'] as String?;

                  if (employeeName == null || isEnrolled == null || employeeEmail == null || employeePhone == null) {
                    return DataRow(cells: [DataCell(SizedBox.shrink()), DataCell(SizedBox.shrink())]);
                  }

                  return DataRow(
                    cells: [
                      DataCell(
                        Text(
                          employeeName,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataCell(
                        Text(
                          employeeEmail,
                        ),
                      ),
                      DataCell(
                        Text(
                          employeePhone,
                        ),
                      ),
                      DataCell(
                        Text(
                          "Requested to delete account",
                        ),
                      ),
                      DataCell(
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () =>
                                  ArtSweetAlert.show(
                                    context: context,
                                    artDialogArgs: ArtDialogArgs(
                                        type: ArtSweetAlertType.warning,
                                        title: "Are you sure",
                                        text: "Do you want to grant permission to delete user account ?",
                                        onConfirm: (){
                                          FirebaseServices.updateDeleteRequest(employeeId, "true", context);
                                          Navigator.of(context).pop();
                                        },
                                      onCancel: (){
                                        FirebaseServices.updateDeleteRequest(employeeId, null, context);
                                        Navigator.of(context).pop();
                                      },
                                      showCancelBtn: true,
                                      confirmButtonColor: Colors.red,
                                      confirmButtonText: "Delete",
                                      cancelButtonColor: Colors.green,
                                      cancelButtonText: "Cancel"
                                    ),
                                  )
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.close,
                                color: Colors.green,
                              ),
                              onPressed: () =>
                                  FirebaseServices.updateDeleteRequest(employeeId, null, context)
                            ),
                          ],
                        )
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
