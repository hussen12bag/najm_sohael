import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/application/Report%20Accident%20pages/mapscreen.dart';
import 'package:flutter_application_2/components/listtile.dart';

class Reportdatasta extends StatefulWidget {
  const Reportdatasta({super.key});

  @override
  State<Reportdatasta> createState() => _ReportdatastaState();
}

class _ReportdatastaState extends State<Reportdatasta> {
  var accounts;
  fun() {
    accounts = FirebaseFirestore.instance.collection('reports').snapshots();
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
              "Report data Statistic",
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
                          "total user:",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text("loading..")
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
                        Text("loading..."),
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      children: [
                        Icon(Icons.file_download_done_sharp),
                        Text(
                          "",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text("loading..."),
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
            "Reports list:",
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
                      itemCount: snapshot.data.docs.length,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    '${snapshot.data.docs[index].data()['data']}',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      Text(
                                        '${snapshot.data.docs[index].data()['userid']}',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                              builder: (context) {
                                                return Mapscreen(
                                                  lat: double.parse(
                                                    '${snapshot.data.docs[index].data()['lat']}',
                                                  ),
                                                  long: double.parse(
                                                    '${snapshot.data.docs[index].data()['long']}',
                                                  ),
                                                );
                                              },
                                            ));
                                          },
                                          icon:
                                              Icon(Icons.location_on_outlined))
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      Text(
                                        '${snapshot.data.docs[index].data()['status']}',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      Text(
                                        'Action',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ));
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
