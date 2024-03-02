import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insta_attend/Database%20Services/FirestoreService.dart';
import 'package:insta_attend/configurations/CardTextStyle.dart';

class EnrollmentRequest extends StatefulWidget {
  const EnrollmentRequest({Key? key}) : super(key: key);

  @override
  State<EnrollmentRequest> createState() => _EnrollmentRequestState();
}

/******** Class to update enrollment of the employee ********/

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

        return SingleChildScrollView(
          child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 300,
                    child: Card(
                      child: ListTile(
                        title: Text(
                          "Enrollment",
                          style: CardTextStyle.titleMobileStyle,
                        ),
                        subtitle: Text("Requests"),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: 500,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        final employeeData = documents[index].data() as Map<String, dynamic>;
                        final employeeId = documents[index].id;
                        final employeeName = employeeData['username'] as String?;
                        final isEnrolled = employeeData['isEnrolled'] as bool?;

                        if (employeeName == null || isEnrolled == null) {
                          return SizedBox.shrink();
                        }

                        return Container(
                          height: 100,
                          child: GestureDetector(
                            onTap: (){
                              FirebaseService.showPopUp(employeeId, isEnrolled, context);
                            },
                            child: Card(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    employeeName,
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              isEnrolled ? Icons.check_circle : Icons.check_circle_outline,
                                              color: Colors.green,
                                            ),
                                            onPressed: () => FirebaseService.updateEnrollment(employeeId, !isEnrolled, context),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
        );
      },
    );
  }
}
