import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/listtile.dart';

class Employeerepsta extends StatefulWidget {
  const Employeerepsta({super.key});

  @override
  State<Employeerepsta> createState() => _EmployeerepstaState();
}

class _EmployeerepstaState extends State<Employeerepsta> {
  var accounts;
  fun() {
    accounts = FirebaseFirestore.instance
        .collection('users')
        .where('status', isEqualTo: "1")
        .snapshots();
    setState(() {});
  }

  @override
  void initState() {
    fun();
    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Container(
            alignment: Alignment.center,
            child: Text(
              "Emp;oyee report Statistic",
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.green,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: SafeArea(
                child: Column(children: <Widget>[
          SizedBox(
            height: 70,
          ),
          Container(
            width: double.infinity,
            height: 100,
            child: CustomListTile(
                icon: Row(
                  children: [
                    Column(
                      children: [
                        Icon(Icons.person),
                        Text(
                          "total employees:",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text("1500")
                      ],
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Column(
                      children: [
                        Icon(Icons.work_history_outlined),
                        Text(
                          "total Reports:",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text("8000"),
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      children: [
                        Icon(Icons.file_download_done_sharp),
                        Text(
                          " Total Reports Completed :",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text("2500"),
                      ],
                    )
                  ],
                ),
                title: Text(""),
                color: Colors.green),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Reports Lsit:",
            style: TextStyle(
                fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            height: MediaQuery.of(context).size.height / 3,
            child: StreamBuilder(
                stream: accounts,
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                    
                      itemCount: snapshot.data.docs.length ,
                      itemBuilder: (context, index) {
                        return Container(
                            margin: const EdgeInsets.only(
                              top: 10,
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 13),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      children: [
                                        Text(
                                          'Employee ID',
                                        ),
                                        const SizedBox(
                                          height: 13,
                                        ),
                                        Text(
                                          'Employee name',
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: [
                                        Text(
                                          'Number of reports',
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: [
                                        Text(
                                          'Number of reports completed',
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: [
                                        Text(
                                          'Number of reports not completed',
                                        ),
                                      ],
                                    ),
                                  ),
                                ]));
                      },
                    );
                  } else {
                    return Center(
                      child: Text('no data'),
                    );
                  }
                }),
          ),
        ]))));
  }
}
