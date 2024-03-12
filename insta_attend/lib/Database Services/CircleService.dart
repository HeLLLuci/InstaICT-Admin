import 'package:admonitions/admonitions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Widget/CircleDropDown.dart';
import '../configurations/CardTextStyle.dart';

class CircleService{
  static Future<void> addCirclePopUp(BuildContext context) async {
    TextEditingController docName = new TextEditingController();
    TextEditingController plusCode = new TextEditingController();
    TextEditingController address = new TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    try {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Add Circle"),
                  IconButton(onPressed: (){Navigator.of(context).pop();}, icon: Icon(Icons.close))
                ],
              ),
              content: Container(
                  height: 300,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.black)),
                          child: TextFormField(
                            controller: docName,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Circle name is mandatory";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter Circle"),
                          ),
                        ),
                        SizedBox(height: 15.0),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.black)),
                          child: TextFormField(
                            controller: plusCode,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Plus Code is mandatory";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                hintText: "Enter PlusCode",
                                border: InputBorder.none),
                          ),
                        ),
                        SizedBox(height: 15.0),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.black)),
                          child: TextFormField(
                            controller: address,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Address is mandatory";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: "Enter Address",
                                border: InputBorder.none),
                          ),
                        ),
                        SizedBox(height: 15.0),
                        Center(
                          child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title:
                                          Text("Are the details correct"),
                                          content: Container(
                                            height: 200,
                                            child: Column(
                                              children: [
                                                Container(
                                                  child: Text("Circle : ${docName.text}"),
                                                ),
                                                SizedBox(height: 10.0),
                                                Container(
                                                  child: Text("Plus Code : ${plusCode.text}"),
                                                ),
                                                SizedBox(height: 10.0),
                                                Container(
                                                  child: Text("Address : ${address.text}"),
                                                ),
                                                SizedBox(height: 25.0),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          var doc =
                                                              docName.text;
                                                          Map<String, dynamic>
                                                          data = {
                                                            "Pluscode":
                                                            plusCode.text,
                                                            "Address":
                                                            address.text
                                                          };
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                              "Circle")
                                                              .doc(doc)
                                                              .set(data);
                                                          Navigator.of(context)
                                                              .pop();
                                                          ScaffoldMessenger.of(
                                                              context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                                content: Text(
                                                                    "Circle added successfully")),
                                                          );
                                                        },
                                                        child: Text("Yes")
                                                    ),
                                                    SizedBox(width: 20.0),
                                                    ElevatedButton(
                                                        onPressed: (){
                                                          Navigator.of(context).pop();
                                                        },
                                                        child: Text("No"))
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                }
                              },
                              child: Text("Submit")
                          ),
                        ),
                      ],
                    ),
                  )
              ),
            );
          });
    } catch (error) {
      print('Error adding circle: $error');
    }
  }

  static Future<void> updateCirclePopUp(BuildContext context) async {
    TextEditingController plusCode = new TextEditingController();
    TextEditingController address = new TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    try {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Update Circle"),
                  IconButton(onPressed: (){Navigator.of(context).pop();}, icon: Icon(Icons.close))
                ],
              ),
              content: Container(
                  height: 300,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CirclesDropdown(),
                        SizedBox(height: 15.0),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.black)),
                          child: TextFormField(
                            controller: plusCode,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Plus code is mandatory";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                hintText: "Enter PlusCode",
                                border: InputBorder.none),
                          ),
                        ),
                        SizedBox(height: 15.0),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.black)),
                          child: TextFormField(
                            controller: address,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Address name is mandatory";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                hintText: "Enter Address",
                                border: InputBorder.none),
                          ),
                        ),
                        SizedBox(height: 15.0),
                        Center(
                          child: ElevatedButton(
                              onPressed: () {
                                if (DocNames.docName.isEmpty) {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: Colors.transparent,
                                          content: GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: SolidAdmonition.danger(
                                              text: "Select circle",
                                              icon: Icon(Icons.dangerous),
                                            ),
                                          ),
                                        );
                                      });
                                } else {
                                  if (_formKey.currentState!.validate()) {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title:
                                            Text("Are the details correct"),
                                            content: Container(
                                              height: 200,
                                              child: Column(
                                                children: [
                                                  Container(
                                                    child: Text("Circle : ${DocNames.docName}"),
                                                  ),
                                                  SizedBox(height: 10.0),
                                                  Container(
                                                    child: Text("Plus Code : ${plusCode.text}"),
                                                  ),
                                                  SizedBox(height: 10.0),
                                                  Container(
                                                    child: Text("Address : ${address.text}"),
                                                  ),
                                                  SizedBox(height: 25.0),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      ElevatedButton(
                                                          onPressed: () {
                                                            var doc =
                                                                DocNames.docName;
                                                            Map<String, dynamic>
                                                            data = {
                                                              "Pluscode":
                                                              plusCode.text,
                                                              "Address":
                                                              address.text
                                                            };
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                "Circle")
                                                                .doc(doc)
                                                                .update(data);
                                                            Navigator.of(context)
                                                                .pop();
                                                            ScaffoldMessenger.of(
                                                                context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                  content: Text(
                                                                      "Circle updated successfully")),
                                                            );
                                                          },
                                                          child: Text("Yes")
                                                      ),
                                                      SizedBox(width: 20.0),
                                                      ElevatedButton(
                                                          onPressed: (){
                                                            Navigator.of(context).pop();
                                                          },
                                                          child: Text("No"))
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  }
                                }
                              },
                              child: Text("Update")),
                        ),
                      ],
                    ),
                  )),
            );
          });
    } catch (error) {
      print('Error adding circle: $error');
    }
  }

  static Future<void> deleteCirclePopUp(BuildContext context) async {
    try {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Delete Circle"),
                  IconButton(onPressed: (){Navigator.of(context).pop();}, icon: Icon(Icons.close))
                ],
              ),
              content: Container(
                  height: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CirclesDropdown(),
                      SizedBox(height: 15.0),
                      Center(
                        child: ElevatedButton(
                            onPressed: () {
                              if (DocNames.docName.isEmpty) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor: Colors.transparent,
                                        content: GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: SolidAdmonition.danger(
                                            text: "Select circle",
                                            icon: Icon(Icons.dangerous),
                                          ),
                                        ),
                                      );
                                    });
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title:
                                        Text("Are the details correct"),
                                        content: Container(
                                          height: 100,
                                          child: Column(
                                            children: [
                                              Container(
                                                child: Text("Circle : ${DocNames.docName}"),
                                              ),
                                              SizedBox(height: 25.0),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        var doc =
                                                            DocNames.docName;
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                            "Circle")
                                                            .doc(doc)
                                                            .delete();
                                                        Navigator.of(context)
                                                            .pop();
                                                        ScaffoldMessenger.of(
                                                            context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                              content: Text(
                                                                  "Circle deleted successfully")),
                                                        );
                                                      },
                                                      child: Text("Yes")
                                                  ),
                                                  SizedBox(width: 20.0),
                                                  ElevatedButton(
                                                      onPressed: (){
                                                        Navigator.of(context).pop();
                                                      },
                                                      child: Text("No"))
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              }
                            },
                            child: Text("Delete")),
                      ),
                    ],
                  )),
            );
          });
    } catch (error) {
      print('Error adding circle: $error');
    }
  }

}