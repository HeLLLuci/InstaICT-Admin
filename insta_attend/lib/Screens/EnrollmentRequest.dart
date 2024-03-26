import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insta_attend/Database%20Services/FirestoreService.dart';
import 'package:insta_attend/configurations/CardTextStyle.dart';

class EnrollmentRequest extends StatefulWidget {
  const EnrollmentRequest({Key? key}) : super(key: key);

  @override
  State<EnrollmentRequest> createState() => _EnrollmentRequestState();
}

class _EnrollmentRequestState extends State<EnrollmentRequest> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('employeeDetails')
          .where('isEnrolled', isEqualTo: false)
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
                "Account Approval",
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

                  if (employeeName == null || employeeEmail == null || employeePhone == null) {
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
                          "Requested to approve account",
                        ),
                      ),
                      DataCell(
                          Row(
                            children: [
                              IconButton(
                                  icon: Icon(
                                    Icons.done,
                                    color: Colors.green,
                                  ),
                                  onPressed: () =>
                                      ArtSweetAlert.show(
                                        context: context,
                                        artDialogArgs: ArtDialogArgs(
                                            type: ArtSweetAlertType.warning,
                                            title: "Are you sure",
                                            text: "Do you want to approve following request?",
                                            onConfirm: (){
                                              FirebaseServices.updateEnrollment(employeeId, true, context);
                                              Navigator.of(context).pop();
                                            },
                                            onCancel: (){
                                              FirebaseServices.updateEnrollment(employeeId, false, context);
                                              Navigator.of(context).pop();
                                            },
                                            showCancelBtn: true,
                                            confirmButtonColor: Colors.green,
                                            confirmButtonText: "Approve",
                                            cancelButtonColor: Colors.red,
                                            cancelButtonText: "Reject"
                                        ),
                                      )
                              ),
                              IconButton(
                                  icon: Icon(
                                    Icons.close,
                                    color: Colors.red,
                                  ),
                                  onPressed: () =>
                                      FirebaseServices.updateEnrollment(employeeId, false, context)
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
