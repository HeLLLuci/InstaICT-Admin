import 'package:flutter/material.dart';
import '../EmployeeData/Tables/employeeDetailTable.dart';

/******** Web screen Layout home content ********/

class WebHomeContent extends StatefulWidget {
  const WebHomeContent({super.key});

  @override
  State<WebHomeContent> createState() => _WebHomeContentState();
}

class _WebHomeContentState extends State<WebHomeContent> {
  @override
  Widget build(BuildContext context) {


    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Summary",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28.0,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Employee Details",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 40.0,
          ),
          employeeDetailTable(),
        ],
      ),
    );
  }
}
