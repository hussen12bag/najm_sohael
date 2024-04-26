import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/application/Admin/acciden_assessment.dart';
import 'package:flutter_application_2/application/Admin/accidentreports.dart';
import 'package:flutter_application_2/application/Admin/showreport.dart';
import 'package:flutter_application_2/application/Report%20Accident%20pages/State2form.dart';
import 'package:flutter_application_2/application/home/widgets/app_bar_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class Reportimage extends StatefulWidget {
  var data;
  Reportimage({required this.data});
  @override
  State<Reportimage> createState() => _ReportimageState();
}

class _ReportimageState extends State<Reportimage> {
  File? file;
  var image;

  getimage() async {
    image = await ImagePicker.platform
        .getImageFromSource(source: ImageSource.gallery);
    if (image != null) {
      file = File(image.path);
      setState(() {});
    }
  }

  getvideo() async {
    final picker = ImagePicker();
    XFile? videofile;
    try {
      await picker.pickVideo(source: ImageSource.gallery);
      return videofile!.path;
    } catch (e) {
      print("Error picking video :$e");
    }
  }

  void _pickedvideo() async {
    var videoURL = getvideo();
    void initvp() {
      var controller = VideoPlayerController.file(File(videoURL!))
        ..initialize().then((value) => {setState(() {})});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: SafeArea(
                child: Column(children: [
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          "Damage Area: ${widget.data['area']}",
          style: TextStyle(fontSize: 20, color: Colors.green),
        ),
      ),
      Container(
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/images/car.png'))),
        width: 200,
        height: 300,
      ),
      SizedBox(
        height: 20,
      ),
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: InkWell(
          onTap: () {
            getimage();
          },
          child: Column(
            children: [
              Text(
                "Images:",
                style: TextStyle(fontSize: 15, color: Colors.green),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Container(
                  width: 300,
                  height: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(widget.data['imageurl']),
                          fit: BoxFit.cover),
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(25)),)
              ),
            ],
          ),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: InkWell(
          onTap: () async {
            _pickedvideo();
          },
          child: Column(
            children: [
              Text(
                "Videos:",
                style: TextStyle(fontSize: 15, color: Colors.green),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Container(
                  width: 300,
                  height: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(widget.data['imageurl']),
                          fit: BoxFit.cover),
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(25)),
                ),
              ),
            ],
          ),
        ),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Accident scenario:",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 250,
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
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
                readOnly: true,
                initialValue: widget.data['sen'],
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
                  fontSize: 16.0,
                  color: Colors.black,
                ),
                cursorColor: Colors.black,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => AccidentReports(),
                ),
              );
            },
            child: Container(
              alignment: Alignment.center,
              child: Text("Return to report page",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              height: 50,
              width: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30), color: Colors.green),
            ),
          )
        ],
      ),
    ]))));
  }
}
