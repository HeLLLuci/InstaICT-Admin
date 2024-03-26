import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:insta_attend/configurations/CardTextStyle.dart';
import 'package:universal_html/html.dart' as html;

class employeeAttendanceTable extends StatefulWidget {
  const employeeAttendanceTable({Key? key});

  @override
  State<employeeAttendanceTable> createState() => _employeeAttendanceTableState();
}

class _employeeAttendanceTableState extends State<employeeAttendanceTable> {
  late List<DocumentSnapshot> filteredDocuments;
  TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  String selectedFilter = 'Date';
  String selectedOrder = 'Descending';
  DateTime? startDate;
  DateTime? endDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Container(
                width: 200,
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
              SizedBox(
                width: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.black,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.filter_alt),
                    SizedBox(
                      width: 10,
                    ),
                    DropdownButton<String>(
                      value: selectedFilter,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedFilter = newValue!;
                        });
                      },
                      items: ['Date', 'Employee Name']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.black,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.sort_by_alpha_outlined),
                    SizedBox(
                      width: 10,
                    ),
                    DropdownButton<String>(
                      value: selectedOrder,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedOrder = newValue!;
                        });
                      },
                      items: ['Ascending', 'Descending']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 20,
              ),
              SizedBox(
                width: 20,
              ),
              AnimatedButton(
                  borderColor: Color(0xFF1c9ef6),
                  backgroundColor: Colors.transparent,
                  selectedTextColor: Colors.white,
                  borderRadius: 15,
                  selectedGradientColor: LinearGradient(colors: [
                    Color(0xFF1bc4fa),
                    Color(0xFF1d78f2)
                  ],
                      begin: Alignment.topCenter,end: Alignment.bottomCenter),
                  width: 200,
                  animatedOn: AnimatedOn.onHover,
                  transitionType: TransitionType.CENTER_ROUNDER,
                  text: "Select Date Range",
                  textStyle: TextStyle(
                      color: Color(0xFF1d78f2)
                  ),
                  onPress: () async{
                    await _selectDateRange(context);
                  }),
              SizedBox(
                width: 10,
              ),
              if (startDate != null && endDate != null)
                AnimatedButton(
                    borderColor: Color(0xFF1c9ef6),
                    backgroundColor: Colors.transparent,
                    selectedTextColor: Colors.white,
                    borderRadius: 15,
                    selectedGradientColor: LinearGradient(colors: [
                      Color(0xFF1bc4fa),
                      Color(0xFF1d78f2)
                    ],
                        begin: Alignment.topCenter,end: Alignment.bottomCenter),
                    width: 200,
                    animatedOn: AnimatedOn.onHover,
                    transitionType: TransitionType.CENTER_ROUNDER,
                    text: "Clear Date Range",
                    textStyle: TextStyle(
                        color: Color(0xFF1d78f2)
                    ),
                    onPress: (){
                      _clearDateRange();
                    }),
              SizedBox(
                width: 10,
              ),
              AnimatedButton(
                  borderColor: Color(0xFF1c9ef6),
                  backgroundColor: Colors.transparent,
                  selectedTextColor: Colors.white,
                  borderRadius: 15,
                  selectedGradientColor: LinearGradient(colors: [
                    Color(0xFF1bc4fa),
                    Color(0xFF1d78f2)
                  ],
                      begin: Alignment.topCenter,end: Alignment.bottomCenter),
                  width: 200,
                  animatedOn: AnimatedOn.onHover,
                  transitionType: TransitionType.CENTER_ROUNDER,
                  text: "Download Report",
                  textStyle: TextStyle(
                      color: Color(0xFF1d78f2)
                  ),
                  onPress: (){
                    downloadCSV();
                  }),
            ],
          ),
        ),
        SizedBox(height: 10.0),
        StreamBuilder<QuerySnapshot>(
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

            List<String> columnOrder = [
              'Employee Name',
              'Date',
              'CheckIn_Time',
              'Check-In Location',
              'CheckOut_Time',
              'Check-Out Location',
              'Duration',
              'Status',
            ];

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
            if (selectedFilter == 'Date') {
              filteredDocuments.sort((a, b) {
                DateTime dateA = DateTime.parse(
                    (a.data() as Map<String, dynamic>)['Date']?.toString() ?? '');
                DateTime dateB = DateTime.parse(
                    (b.data() as Map<String, dynamic>)['Date']?.toString() ?? '');

                return selectedOrder == 'Ascending' ? dateA.compareTo(dateB) : dateB.compareTo(dateA);
              });
            } else if (selectedFilter == 'Employee Name') {
              filteredDocuments.sort((a, b) {
                String nameA =
                    (a.data() as Map<String, dynamic>)['Employee Name']?.toString().toLowerCase() ?? '';
                String nameB =
                    (b.data() as Map<String, dynamic>)['Employee Name']?.toString().toLowerCase() ?? '';

                return selectedOrder == 'Ascending' ? nameA.compareTo(nameB) : nameB.compareTo(nameA);
              });
            } else if (selectedFilter == 'Status') {
              // Add logic to handle sorting by Status
            }

            return Scrollbar(
              controller: controllers.scrollController,
              scrollbarOrientation: ScrollbarOrientation.top,
              child: SingleChildScrollView(
                controller: controllers.scrollController,
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
                  ],
                  rows: [
                    for (var document in filteredDocuments)
                      if (_isDateInRange(document))
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
                          ],
                        ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  /********** Future function to add data range filter by using which we can get records between specific range *********/

  Future<void> _selectDateRange(BuildContext context) async {
    DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        startDate = picked.start;
        endDate = picked.end;
      });
    }
  }

  bool _isDateInRange(DocumentSnapshot document) {
    if (startDate == null || endDate == null) {
      return true;
    }

    DateTime documentDate = DateTime.parse((document.data() as Map<String, dynamic>)['Date']?.toString() ?? '');
    return documentDate.isAfter(startDate!) && documentDate.isBefore(endDate!.add(Duration(days: 1)));
  }

  /********** Function to clear the data range *********/

  void _clearDateRange() {
    setState(() {
      startDate = null;
      endDate = null;
    });
  }

  /************ Function to which does following things
   * 1. Fetch attendance records from databse
   * 2. Add these records to List of List
   * 3. Converts this list to CSV file
   * 4. Download this CSV file by converting it to downloadable blob object *************/
  void downloadCSV() {
    List<List<String>> records = [];
    records.add([
      'Employee Name',
      'Date',
      'Check-In Time',
      'Check-In Location',
      'Check-Out Time',
      'Check-Out Location',
      'Duration',
      'Status',
    ]);
    for (var document in filteredDocuments) {
      if (_isDateInRange(document)) {
        records.add([

          //implementing Elvis Operator which helps in handling null value occurrences.

          (document.data() as Map<String, dynamic>)['Employee Name']?.toString() ?? '',
          (document.data() as Map<String, dynamic>)['Date']?.toString() ?? '',
          (document.data() as Map<String, dynamic>)['CheckIn_Time']?.toString() ?? '',
          (document.data() as Map<String, dynamic>)['Check-In Location']?.toString() ?? '',
          (document.data() as Map<String, dynamic>)['CheckIn_Time']?.toString() ?? '',
          (document.data() as Map<String, dynamic>)['Check-Out Location']?.toString() ?? '',
          (document.data() as Map<String, dynamic>)['Duration']?.toString() ?? '',
          (document.data() as Map<String, dynamic>)['Status']?.toString() ?? '',
        ]);
      }
    }
    String csvData = ListToCsvConverter().convert(records);
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
}
