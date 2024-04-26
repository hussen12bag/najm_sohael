import 'package:flutter/material.dart';
import 'package:flutter_application_2/application/Admin/showimagereport.dart';
import 'package:flutter_application_2/application/Report%20Accident%20pages/mapscreen.dart';
import 'package:flutter_application_2/application/Report%20Accident%20pages/statmentform.dart';
import 'package:flutter_application_2/application/home/widgets/app_bar_widget.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class ShowReport extends StatefulWidget {
  var data;
  ShowReport({required this.data});
  @override
  State<ShowReport> createState() => _ShowReportState();
}

class _ShowReportState extends State<ShowReport> {
  GoogleMapController? mapController;
  Position? cl;
  var lat;
  var long;
  CameraPosition? _kGooglePlex;
  late Set<Marker> mymarker;

  getlocation() async {
    PermissionStatus status = await Permission.location.request();
    if (status == PermissionStatus.denied) {
      await Geolocator.requestPermission();
    }
    if (status == PermissionStatus.granted) {
      await getLatLong();
    }
  }

  getLatLong() async {
    lat = double.parse(widget.data['lat']);
    long = double.parse(widget.data['long']);
    _kGooglePlex = CameraPosition(
      target: LatLng(lat, long),
      tilt: 0.5,
      zoom: 12,
    );
    if (!mounted) return;
    setState(() {
      mymarker = {
        Marker(markerId: MarkerId("1"), position: LatLng(lat, long)),
        Marker(
            onDragEnd: ((LatLng) => {print(LatLng)}),
            markerId: MarkerId("1"),
            position: LatLng(lat, long))
      };
    });
  }

  void initState() {
    getlocation();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                "Report",
                style: TextStyle(fontSize: 20, color: Colors.green),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "1-There is no injuries in the accident",
              style: TextStyle(fontSize: 20, color: Colors.green),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 25.0),
              child: Text(
                "2- The user have a valid insurance",
                style: TextStyle(fontSize: 20, color: Colors.green),
              ),
            ),
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Text(
                  '3- The number of parties involved in the incident',
                  style: TextStyle(fontSize: 20, color: Colors.green),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  readOnly: false,
                  initialValue: widget.data['num'],
                  enabled: true,
                  decoration: InputDecoration(
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: Colors.black)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: Colors.black)),
                    hintStyle: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0.5, horizontal: 10.0),
                  ),
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                  cursorColor: Colors.black,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 160),
                child: Text(
                  '4- Car form number',
                  style: TextStyle(fontSize: 20, color: Colors.green),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  readOnly: true,
                  initialValue: widget.data['carFormNumber'],
                  enabled: true,
                  decoration: InputDecoration(
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: Colors.black)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: Colors.black)),
                    hintStyle: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0.5, horizontal: 10.0),
                  ),
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                  cursorColor: Colors.black,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 160),
                child: Text(
                  '5- Insurance company',
                  style: TextStyle(fontSize: 20, color: Colors.green),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  readOnly: true,
                  initialValue: widget.data['insuranceNumber'],
                  enabled: true,
                  decoration: InputDecoration(
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: Colors.black)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: Colors.black)),
                    hintStyle: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0.5, horizontal: 10.0),
                  ),
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                  cursorColor: Colors.black,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 160),
                child: Text(
                  '6- Car plate number',
                  style: TextStyle(fontSize: 20, color: Colors.green),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  readOnly: true,
                  initialValue: widget.data['carPlateNumber'],
                  enabled: true,
                  decoration: InputDecoration(
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: Colors.black)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: Colors.black)),
                    hintStyle: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0.5, horizontal: 10.0),
                  ),
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                  cursorColor: Colors.black,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(
                  '7- Car plate number of the other party',
                  style: TextStyle(fontSize: 20, color: Colors.green),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  enabled: true,
                  readOnly: true,
                  initialValue: widget.data['carPlateNumber2'],
                  decoration: InputDecoration(
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: Colors.black)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: Colors.black)),
                    hintStyle: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0.5, horizontal: 10.0),
                  ),
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                  cursorColor: Colors.black,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 200),
                child: Text(
                  '8- Car company',
                  style: TextStyle(fontSize: 20, color: Colors.green),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  readOnly: true,
                  initialValue: widget.data['carCompany'],
                  enabled: false,
                  decoration: InputDecoration(
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: Colors.black)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: Colors.black)),
                    hintStyle: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0.5, horizontal: 10.0),
                  ),
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                  cursorColor: Colors.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 230),
                child: Text(
                  '9- Car model',
                  style: TextStyle(fontSize: 20, color: Colors.green),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  readOnly: true,
                  initialValue: widget.data['carModel'],
                  enabled: false,
                  decoration: InputDecoration(
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: Colors.black)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: Colors.black)),
                    hintStyle: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0.5, horizontal: 10.0),
                  ),
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                  cursorColor: Colors.black,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "Accident location:",
                style: TextStyle(fontSize: 20, color: Colors.green),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: TextEditingController(
                      text:
                          "${widget.data['lat']} 'N ${widget.data['long']}'E"),
                  enabled: true,
                  decoration: InputDecoration(
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: Colors.black)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: Colors.black)),
                    hintStyle: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0.5, horizontal: 10.0),
                  ),
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                  cursorColor: Colors.black,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                width: 300,
                height: 400,
                child: _kGooglePlex == null
                    ? Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Stack(
                        children: [
                          GoogleMap(
                            onTap: (LatLng) async {
                              setState(() {});
                            },
                            markers: mymarker,
                            mapType: MapType.normal,
                            initialCameraPosition: _kGooglePlex!,
                            onMapCreated: (GoogleMapController controller) {
                              mapController = controller;
                            },
                          ),
                        ],
                      ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Reportimage(
                          data:widget.data
                        ),
                      ));
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Next",
                    style: TextStyle(color: Colors.white),
                  ),
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.green),
                ),
              ),
              SizedBox(
                height: 10,
              )
            ])
          ],
        )),
      ),
    );
  }
}
