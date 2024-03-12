import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:insta_attend/Database%20Services/CircleService.dart';
import 'package:insta_attend/Widget/Animations/Loading.dart';

class addCircle extends StatefulWidget {
  addCircle({super.key});

  @override
  State<addCircle> createState() => _addCircleState();
}

class _addCircleState extends State<addCircle> {
  late final List<String> circleNames;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                text: "Add Circle",
                textStyle: TextStyle(
                    color: Color(0xFF1d78f2)
                ),
                onPress: (){
                CircleService.addCirclePopUp(context);
                }), SizedBox(height: 20.0,),
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
                text: "Update Circle",
                textStyle: TextStyle(
                    color: Color(0xFF1d78f2)
                ),
                onPress: (){
                  CircleService.updateCirclePopUp(context);
                }), SizedBox(height: 20.0,),
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
                text: "Delete Circle",
                textStyle: TextStyle(
                    color: Color(0xFF1d78f2)
                ),
                onPress: (){
                  CircleService.deleteCirclePopUp(context);
                }), SizedBox(height: 20.0,),
            Divider(color: Colors.grey,),
            SizedBox(height: 20.0,),
            ListTile(
              title: Text("Available Circles"),
            ),
            SizedBox(
              height: 20.0,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('Circle').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var circles = snapshot.data!.docs;

                  return DataTable(
                    dividerThickness: 1,
                    border: TableBorder.all(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    headingRowColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                      return Colors.grey; // Highlight color for column titles
                    }),
                    columns: [

                      DataColumn(
                        label: Text(
                          'Circle Name',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Plus Code',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Address',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                    rows: circles.map<DataRow>((circle) {
                      var circleData = circle.data() as Map<String, dynamic>;
                      return DataRow(
                        cells: [
                          DataCell(Text(circle.id)),
                          DataCell(Text(circleData['Pluscode'].toString())),
                          DataCell(Text(circleData['Address'].toString())),
                        ],
                      );
                    }).toList(),
                  );
                } else {
                  return LoadingAnimation();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
