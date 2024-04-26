import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/application/Admin/ADMINchat.dart';
import 'package:flutter_application_2/main.dart';

class Rooms extends StatefulWidget {
  const Rooms({super.key});

  @override
  State<Rooms> createState() => _RoomsState();
}

class _RoomsState extends State<Rooms> {
  var rooms;

  getRooms() async {
    rooms = FirebaseFirestore.instance
        .collection('rooms')
        .where(
          Filter.or(
            Filter("userid2", isEqualTo: "${prefs!.getString('id')}"),
            Filter("userid1", isEqualTo: "${prefs!.getString('id')}"),
          ),
        )
        .snapshots();
    setState(() {});
    // print(rooms.docs.length);
  }

  @override
  void initState() {
    getRooms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: rooms,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return AdminChat(
                                    roomid:
                                        snapshot.data.docs[index].reference.id,
                                  
                                      
                                   
                                    id: snapshot.data.docs[index].data()['userid1'] !=
                                            "${prefs!.getString('id')}"
                                        ? snapshot.data.docs[index]
                                            .data()['userid1']
                                        : snapshot.data.docs[index]
                                            .data()['userid2']);
                              },
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.only(bottom: 10),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.grey),
                            ),
                          ),
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('user number: '),
                              Text(prefs!.getString('id') ==
                                      snapshot.data.docs[index]
                                          .data()['userid1']
                                  ? snapshot.data.docs[index].data()['userid1']
                                  : snapshot.data.docs[index].data()['userid2'])
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.chat,
                        color: const Color.fromARGB(255, 214, 212, 212),
                        size: 100,
                      ),
                      Text('')
                    ],
                  ),
                );
        },
      ),
    );
  }
}
