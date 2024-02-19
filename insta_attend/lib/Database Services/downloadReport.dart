import 'dart:convert' show utf8;
import 'dart:typed_data';
import 'package:universal_html/html.dart' as html;
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> downloadAttendanceCollectionAsCSV(Stream<QuerySnapshot> stream) async {
  List<Map<String, dynamic>> records = [];

  await for (QuerySnapshot snapshot in stream) {
    for (QueryDocumentSnapshot document in snapshot.docs) {
      records.add(document.data() as Map<String, dynamic>);
    }
  }

  if (records.isNotEmpty) {
    List<String> columnOrder = ['Employee Name', 'Date', 'Check-In Time', 'Check-In Location', 'Check-Out Time', 'Check-Out Location', 'Status'];

    String header = columnOrder.join(',') + '\n';
    String content = header;

    for (var record in records) {
      String row = columnOrder.map((field) => '${record[field] ?? ''}').join(',') + '\n';
      content += row;
    }

    final fileName = "Attendance Record" + DateTime.now().toString() + ".csv";

    // Create a Blob with the CSV data
    final Uint8List uint8List = Uint8List.fromList(utf8.encode(content));
    final html.Blob blob = html.Blob([uint8List]);

    // Create an ObjectURL for the Blob
    final url = html.Url.createObjectUrlFromBlob(blob);

    final html.AnchorElement anchor = html.AnchorElement(href: url)
      ..target = 'blank'
      ..download = fileName;

    html.document.body!.children.add(anchor);
    anchor.click();

    html.Url.revokeObjectUrl(url);
  }
}
