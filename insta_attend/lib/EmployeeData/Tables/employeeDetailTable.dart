import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insta_attend/Widget/Animations/Loading.dart';


/********** Class which simply fetches employee details and represents them in tabular form *********/

class employeeDetailTable extends StatefulWidget {
  const employeeDetailTable({Key? key});

  @override
  _employeeDetailTableState createState() => _employeeDetailTableState();
}

class _employeeDetailTableState extends State<employeeDetailTable> {
  late List<DocumentSnapshot> filteredDocuments;
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('employeeDetails').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: LoadingAnimation()
          );
        }

        //firebase deploy
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        final documents = snapshot.data!.docs;
        filteredDocuments = List.from(documents);

        if (documents.isEmpty) {
          return Center(child: Text('No data available.'));
        }

        List<String> columnOrder = ['username', 'email', 'phoneNumber','Circle', 'isEnrolled', 'geoFencing'];
        List<String> columnList = ["Employee Name", "Email", "Phone Number","Circle", "Activation", "GeoFencing"];

        if (searchController.text.isNotEmpty) {
          filteredDocuments = documents.where((document) {
            bool containsSearchQuery = false;
            for (var field in columnOrder) {
              String fieldValue = (document.data() as Map<String, dynamic>)[field]?.toString() ?? '';
              if (fieldValue.toLowerCase().contains(searchController.text.toLowerCase())) {
                containsSearchQuery = true;
                break;
              }
            }
            return containsSearchQuery;
          }).toList();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 500,
              child: TextField(
                controller: searchController,
                onSubmitted: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black26,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: MaterialStateProperty.resolveWith((states) => Colors.grey.shade200),
                columns: [
                  for (var field in columnList)
                    DataColumn(label: Text(field)),
                ],
                rows: [
                  for (var document in filteredDocuments)
                    DataRow(
                      cells: [
                        for (var field in columnOrder)
                          DataCell(
                            field == 'isEnrolled' || field == 'geoFencing'
                                ? Text(
                              ((document.data() as Map<String, dynamic>)[field] ?? false) ? 'Active' : 'Inactive',
                            )
                                : Text((document.data() as Map<String, dynamic>)[field]?.toString() ?? ''),
                          ),
                      ],
                    ),
                ],
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
          ],
        );
      },
    );
  }
}
