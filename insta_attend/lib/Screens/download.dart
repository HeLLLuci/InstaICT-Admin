import 'dart:convert';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:universal_html/html.dart' as html;
import 'package:csv/csv.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/******** Class to Download attendance report but now not usable in code ********/

final db = FirebaseFirestore.instance;
List<List<String>> itemList = [];

class DownloadFile extends StatefulWidget {
  @override
  State<DownloadFile> createState() => _DownloadFileState();
}

class _DownloadFileState extends State<DownloadFile> {
  Stream<QuerySnapshot> streamQuery = db.collection('attendance').snapshots();

  @override
  void initState() {
    super.initState();
    itemList = [
      [
        'Employee Name',
        'Date',
        'Check-In Time',
        'Check-In Location',
        'Check-Out Time',
        'Check-Out Location',
        'Duration',
        'Status'
      ]
    ];
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: streamQuery,
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else{
            return Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(onPressed: (){
                    generateCSV();
                    print(snapshot.data!.docs.length);
                    print(itemList.length);
                    print(itemList.length);
                    for (List<String> item in itemList) {
                      print(item);

                    }
                  }, child: Text("Download")),
                  SizedBox(
                    height: 20,
                  ),
                  Text("These are the Records to be downloaded"),
                  Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index){
                          DocumentSnapshot doc = snapshot.data!.docs[index];
                            itemList.add(<String>[
                              doc.get('Employee Name'),
                              doc.get('Date'),
                              doc.get('Check-In Time'),
                              doc.get('Check-In Location'),
                              doc.get('Check-Out Time'),
                              doc.get('Check-Out Location'),
                              doc.get('Duration'),
                              doc.get('Status')]);

                          return Slidable(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Card(
                                  color: Colors.red,
                                  elevation: 16,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Wrap(
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            color: Theme.of(context).colorScheme.background
                                        ),
                                        margin: EdgeInsets.only(
                                            left: 10
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 10
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Employee Name: ${doc.get("Employee Name")}"),
                                            Text("Date: ${doc.get("Date")}"),
                                            Text("Check-In Location: ${doc.get("Check-In Location")}"),
                                            Text("Check-In Time: ${doc.get("Check-In Time")}"),
                                            Text("Check-Out Location: ${doc.get("Check-Out Location")}"),
                                            Text("Check-Out Time: ${doc.get("Check-Out Time")}"),
                                            Text("Duration: ${doc.get("Duration")}"),
                                            Text("Status: ${doc.get("Status")}"),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ));
                        }
                    ),
                  ),
                ],
              ),
            );
          }
        }
    );
  }
}

generateCSV() {
  String csvData = ListToCsvConverter().convert(itemList);
  DateTime now = DateTime.now();
  if (kIsWeb) {
    final byte = utf8.encode(csvData);
    final blob = html.Blob([byte]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..style.display = 'none'
      ..download = 'Attendance_Record_${now.toLocal()}.csv';
    html.document.body!.children.add(anchor);
    anchor.click();
    html.Url.revokeObjectUrl(url);
  }
}
