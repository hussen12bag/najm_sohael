import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/application/dashboard/widgets/report_widget.dart';
import 'package:flutter_application_2/main.dart';
 
import '../widgets/my_reports_screen_button_widget.dart';

var currentReportsList;

class MyReportsScreen extends StatefulWidget {
  const MyReportsScreen({super.key});

  @override
  State<MyReportsScreen> createState() => _MyReportsScreenState();
}

class _MyReportsScreenState extends State<MyReportsScreen> {
  bool previousReports = true;
  bool currentReports = false;
  @override
  void initState() {
    getMyReposts();
    super.initState();
  }

  var previousReportsList;

  getMyReposts() async {
    currentReportsList = FirebaseFirestore.instance
        .collection('reports')
        .where(
          "userid",
          isEqualTo: prefs!.getString('id'),
        )
        .snapshots();
    previousReportsList = currentReportsList;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'My reports',
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.green,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyReportsScreenButtonWidget(
                onTap: () {
                  setState(() {
                    previousReports = true;
                    currentReports = false;
                    getMyReposts();
                  });
                },
                isActive: previousReports,
                data: 'Previous reports'),
            MyReportsScreenButtonWidget(
                onTap: () {
                  setState(() {
                    previousReports = false;
                    currentReports = true;
                    getMyReposts();
                  });
                },
                isActive: currentReports,
                data: 'Current reports'),
          ],
        ),
        Visibility(
          visible: previousReports,
          child: Expanded(
              child: StreamBuilder(
                  stream: previousReportsList,
                  builder: (context, AsyncSnapshot snapshot) {
                    return snapshot.hasData
                        ? ListView.separated(
                            itemBuilder: (context, index) {
                              return ReportWidget(
                                  lat: snapshot.data.docs[index].data()['lat'],
                                  long:
                                      snapshot.data.docs[index].data()['long'],
                                  reportId:
                                      snapshot.data.docs[index].reference.id,
                                  date:
                                      '${snapshot.data.docs[index].data()['data']}',
                                  location:
                                      '${snapshot.data.docs[index].data()['lat']}' +'N'
                                          '${snapshot.data.docs[index].data()['long']}',
                                  decisionPercentage:
                                      '${snapshot.data.docs[index].data()['percent']}',
                                  reasoning:
                                      '${snapshot.data.docs[index].data()['reason']}');
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 5.0),
                            itemCount: snapshot.data.docs.length,
                          )
                        : const Center(
                            child: Text(
                              'No reports found',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.green,
                              ),
                            ),
                          );
                  })),
        ),
        Visibility(
          visible: currentReports,
          child: Expanded(
              child: StreamBuilder(
                  stream: currentReportsList,
                  builder: (context, AsyncSnapshot snapshot) {
                    return snapshot.hasData
                        ? ListView.separated(
                            itemBuilder: (context, index) {
                              return ReportWidget(
                                  lat:
                                      '${snapshot.data.docs[index].data()['lat']}',
                                  long:
                                      '${snapshot.data.docs[index].data()['long']}',
                                  reportId:
                                      '${snapshot.data.docs[index].reference.id}',
                                  date:
                                      '${snapshot.data.docs[index].data()['data']}',
                                location:
                                      '${snapshot.data.docs[index].data()['lat']}' +'N'
                                          '${snapshot.data.docs[index].data()['long']}',
                                  decisionPercentage:
                                      '${snapshot.data.docs[index].data()['percent']}',
                                  reasoning:
                                      '${snapshot.data.docs[index].data()['reason']}');
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 5.0),
                            itemCount: snapshot.data.docs.length,
                          )
                        : const Center(
                            child: Text(
                              'No reports found',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.green,
                              ),
                            ),
                          );
                  })),
        ),
      ],
    );
  }
}
