import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_2/application/Admin/admingome.dart';
import 'package:flutter_application_2/components/listtile.dart';

class AccidentAssessment extends StatefulWidget {
  String reportID;
  var data;
  AccidentAssessment({required this.data, required this.reportID});
  @override
  State<AccidentAssessment> createState() => _AccidentAssessmentState();
}

class _AccidentAssessmentState extends State<AccidentAssessment> {
  List users = [];
  bool? des = false;
  bool? des1 = false;

  TextEditingController controller = TextEditingController();
  TextEditingController per1 = TextEditingController();
  TextEditingController per2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.center,
          child: Text(
            "Accident assessment",
            style: TextStyle(
                fontSize: 25, color: Colors.green, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Involved parties:",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.lightGreen,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Decision percentage:",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.lightGreen,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Container(
                height: 200,
                child: ListView.builder(
                    itemCount: 2,
                    itemBuilder: (context, i) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 200,
                              height: 80,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              child: CustomListTile(
                                  icon: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(24)),
                                      child: Icon(Icons.person)),
                                  title: i == 0
                                      ? Text(
                                          "Car ID:   ${widget.data['carPlateNumber']}")
                                      : Text(
                                          "Car ID:   ${widget.data['carPlateNumber2']}"),
                                  color: Colors.green),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                            width: 60,
                            // color: Colors.red,
                            child: TextFormField(
                              controller: i == 0 ? per1 : per2,
                              keyboardType: TextInputType.number,
                              cursorColor: Colors.green,
                            ),
                          ),
                        ],
                      );
                    }),
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.all(15),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Reasoning:",
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.lightGreen,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 250,
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: const Offset(0.0, 0.3),
                        blurRadius: 0.5,
                        spreadRadius: 0.3,
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller: controller,
                    // enabled: true,
                    // decoration: InputDecoration(
                    //   disabledBorder: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(50),
                    //       borderSide: BorderSide(color: Colors.black)),
                    //   enabledBorder: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(50),
                    //       borderSide: BorderSide(color: Colors.black)),
                    //   hintStyle: TextStyle(
                    //     fontSize: 14.0,
                    //     color: Colors.black,
                    //   ),
                    //   border: OutlineInputBorder(
                    //       borderSide: BorderSide.none,
                    //       borderRadius: BorderRadius.all(Radius.circular(50))),
                    //   contentPadding:
                    //       EdgeInsets.symmetric(vertical: 0.5, horizontal: 10.0),
                    // ),
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                    ),
                    cursorColor: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () async {
                  if ((controller.text.isNotEmpty ||
                          per1.text.isNotEmpty ||
                          per2.text.isNotEmpty) &&
                      controller.text.isNotEmpty) {
                    await FirebaseFirestore.instance
                        .collection('reports')
                        .doc(widget.reportID)
                        .set({
                      "status": "submitted",
                      "percent": "${per1.text}",
                      "reason": controller.text
                    }, SetOptions(merge: true)).then((value) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdminHome(),
                          ));
                    });
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Text("Submit final decision",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.green),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
