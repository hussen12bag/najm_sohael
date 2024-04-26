import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_2/application/Admin/acciden_assessment.dart';
import 'package:flutter_application_2/application/Admin/showreport.dart';
import 'package:flutter_application_2/application/dashboard/widgets/chat_message_widget.dart';
import 'package:flutter_application_2/components/list.dart';
import 'package:flutter_application_2/components/listtile.dart';

class AccidentReports extends StatefulWidget {
  const AccidentReports({super.key});

  @override
  State<AccidentReports> createState() => _AccidentReportsState();
}

class _AccidentReportsState extends State<AccidentReports> {
  List reports = [
    {"newreport": "New Report", "Report ID": "555", "time": "2min"},
    {"newreport": "New Report", "Report ID": "555", "time": "2min"},
    {"newreport": "New Report", "Report ID": "555", "time": "2min"}
  ];
  var newreports;
  var subs;

  getMessages() async {
    newreports = FirebaseFirestore.instance
        .collection('reports')
        .where('status', isEqualTo: 'not processed')
        .snapshots();
    setState(() {});
  }

  getRepo() async {
    subs = FirebaseFirestore.instance
        .collection('reports')
        .where('status', isEqualTo: 'submitted')
        .snapshots();
    setState(() {});
  }

  @override
  void initState() {
    getMessages();
    getRepo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Container(
            alignment: Alignment.center,
            child: Text(
              "Accident Reports",
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.green,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
              child: Column(children: [
            Container(
              padding: EdgeInsets.all(15),
              alignment: Alignment.centerLeft,
              child: Text(
                "New Reports",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              height: 200,
              child: StreamBuilder(
                  stream: newreports,
                  builder: (context, AsyncSnapshot snapshot) {
                    return !snapshot.hasData
                        ? Text('')
                        : ListView.builder(
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, i) {
                              return Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: CustomListTile(
                                    title: Text(''),
                                    icon: InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return ShowReport(
                                                data: snapshot.data.docs[i]
                                                    .data(),
                                              );
                                            },
                                          ),
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "New",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                "Report",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "|",
                                            style: TextStyle(
                                                fontSize: 40,
                                                color: Colors.white),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                              "Report ID : ${Random().nextInt(100)}    ${snapshot.data.docs[i].data()['data']}",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.white)),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      return AccidentAssessment(
                                                        reportID: snapshot
                                                            .data
                                                            .docs[i]
                                                            .reference
                                                            .id,
                                                        data: snapshot
                                                            .data.docs[i]
                                                            .data(),
                                                      );
                                                    },
                                                  ),
                                                );
                                              },
                                              icon: Container(
                                                  width: 40,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25)),
                                                  child: Icon(
                                                    Icons.arrow_forward,
                                                    color: Colors.green,
                                                  ))),
                                          SizedBox(
                                            width: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                    color: Colors.green),
                              );
                            });
                  }),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              padding: EdgeInsets.all(15),
              alignment: Alignment.centerLeft,
              child: Text(
                "Completed Reports",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              height: 200,
              child: StreamBuilder(
                  stream: subs,
                  builder: (context, AsyncSnapshot snapshot) {
                    return !snapshot.hasData
                        ? Text('')
                        : ListView.builder(
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, i) {
                              return Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: list(
                                    title: Text(''),
                                    icon: InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return ShowReport(
                                                data: snapshot.data.docs[i]
                                                    .data(),
                                              );
                                            },
                                          ),
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "New",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                "Report",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "|",
                                            style: TextStyle(
                                                fontSize: 40,
                                                color: Colors.white),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                              "Report ID : ${Random().nextInt(100)}    ${snapshot.data.docs[i].data()['data']}",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.white)),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                    color: Colors.green),
                              );
                            });
                  }),
            ),
          ])),
        ));
  }
}
