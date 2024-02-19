import 'package:flutter/material.dart';

class FilterBar extends StatelessWidget {
  const FilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          children: [
            DropdownButton(
                hint: Text("Filter by"),
                items: [
                  DropdownMenuItem(
                    value: "Date",
                    child: Text("Date"),
                  ),
                  DropdownMenuItem(
                    value: "Status",
                    child: Text("Status"),
                  ),
                  DropdownMenuItem(
                    value: "Name",
                    child: Text("Name"),
                  ),
                ],
                onChanged: (value) {}),
            SizedBox(
              width: 20.0,
            ),
            DropdownButton(
                hint: Text("Order by"),
                items: [
                  DropdownMenuItem(
                    value: "Date",
                    child: Text("Date"),
                  ),
                  DropdownMenuItem(
                    value: "Status",
                    child: Text("Status"),
                  ),
                  DropdownMenuItem(
                    value: "Name",
                    child: Text("Name"),
                  ),
                ],
                onChanged: (value) {}),
          ],
        ),
      ],
    );
  }
}
