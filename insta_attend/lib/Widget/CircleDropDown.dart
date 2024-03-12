import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../configurations/CardTextStyle.dart';

class CirclesDropdown extends StatefulWidget {
  @override
  _CirclesDropdownState createState() => _CirclesDropdownState();
}

class _CirclesDropdownState extends State<CirclesDropdown> {
  final _firestore = FirebaseFirestore.instance;
  String circle = "Select Circle";
  bool _showPopup = true;
  List<PopupMenuEntry<String>> _dropdownItems = [];

  Future<void> _fetchCircles() async {
    try {
      final circles = await _firestore.collection('Circle').get();
      List<PopupMenuEntry<String>> dropdownItems = [];
      setState(() {
        _showPopup = true;
        _dropdownItems = dropdownItems;
      });
      for (var doc in circles.docs) {
        String circleId = doc.id;
        dropdownItems.add(
          PopupMenuItem<String>(value: circleId, child: Text(circleId)),
        );
      }
    } catch (error) {
      print("Error fetching circles: $error");
    }
  }

  @override
  void initState() {
    _fetchCircles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _showPopup
            ? Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: Colors.blue, width: 1)),
          child: PopupMenuButton<String>(
              padding: EdgeInsets.symmetric(vertical: 2.0),
              onSelected: (value) {
                setState(() {
                  circle = value;
                  DocNames.docName = value;
                });
              },
              child: Text(
                circle,
                style: TextStyle(color: Colors.white),
              ),
              itemBuilder: (context) => _dropdownItems),
        )
            : SizedBox(),
      ],
    );
  }
}
