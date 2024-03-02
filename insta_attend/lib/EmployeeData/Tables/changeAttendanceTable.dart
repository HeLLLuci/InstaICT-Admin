import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insta_attend/Database%20Services/changeAttendanceStatus.dart';


/********** Class which shows attendance records ( only Employee Name, Date and Status)
 * ******** It first fetch records from database then implements update function on click of button next to each record *********/

class changeAttendanceTable extends StatefulWidget {
  const changeAttendanceTable({Key? key}) : super(key: key);
  @override
  State<changeAttendanceTable> createState() => _changeAttendanceTableState();
}
class _changeAttendanceTableState extends State<changeAttendanceTable> {
  late List<DocumentSnapshot> filteredDocuments;
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('attendance').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        final documents = snapshot.data!.docs;
        filteredDocuments = List.from(documents);

        if (documents.isEmpty) {
          return Center(child: Text('No data available.'));
        }
        List<String> columnOrder = ['Employee Name', 'Date', 'Status'];
        if (searchController.text.isNotEmpty) {
          filteredDocuments = documents.where((document) {
            bool containsSearchQuery = false;
            for (var field in columnOrder) {
              String fieldValue =
                  (document.data() as Map<String, dynamic>)[field]?.toString() ?? '';
              if (fieldValue.toLowerCase().contains(searchController.text.toLowerCase())) {
                containsSearchQuery = true;
                break;
              }
            }
            return containsSearchQuery;
          }).toList();
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
                headingRowColor:
                MaterialStateProperty.resolveWith((states) => Colors.grey.shade200),
                columns: [
                  for (var field in columnOrder)
                    DataColumn(
                      label: Text(
                        field,
                        style: TextStyle(fontSize: 12.0),
                      ),
                    ),
                  DataColumn(
                    label: Text(
                      'Actions',
                      style: TextStyle(fontSize: 12.0),
                    ),
                  ),
                ],
                rows: [
                  for (var document in filteredDocuments)
                    DataRow(
                      cells: [
                        for (var field in columnOrder)
                          DataCell(
                            SizedBox(
                              width: 150,
                              child: Text(
                                (document.data() as Map<String, dynamic>)[field]?.toString() ?? '',
                                style: TextStyle(fontSize: 12.0),
                              ),
                            ),
                          ),
                        DataCell(
                          IconButton(
                            icon: Icon(Icons.edit_calendar_outlined),
                            onPressed: () {
                              ChangeAttendanceStatus.showEditDialog(context, document);
                            },
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
