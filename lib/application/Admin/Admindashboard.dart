import 'package:flutter/material.dart';
import 'package:flutter_application_2/application/Admin/accidentreports.dart';
import 'package:flutter_application_2/application/Admin/accidentstatistics.dart';
import 'package:flutter_application_2/application/Admin/rooms.dart';
import 'package:flutter_application_2/application/Report%20Accident%20pages/primaryquestion.dart';
import 'package:flutter_application_2/application/authentication/screens/login_screen.dart';
import 'package:flutter_application_2/application/dashboard/screens/customer_service_faq_screen.dart';
import 'package:flutter_application_2/application/dashboard/screens/my_reports_screen.dart';
import 'package:flutter_application_2/application/dashboard/screens/track_accident_report_screen.dart';
import 'package:flutter_application_2/application/dashboard/widgets/card_widget.dart';
import 'package:flutter_application_2/main.dart';
import 'package:flutter_application_2/utils/functions.dart';

class Admindashboard extends StatefulWidget {
  const Admindashboard({super.key});

  @override
  State<Admindashboard> createState() => _AdmindashboardState();
}

class _AdmindashboardState extends State<Admindashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.of(context, rootNavigator: true)
                      .push(MaterialPageRoute(
                    builder: (context) => AccidentReports(),
                  ));
                },
                child: const CardWidget(
                    icon: Icons.data_thresholding_rounded,
                    data: 'Accedint Report')),
            const SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Accidentsta(),
                    ));
              },
              child: const CardWidget(
                  icon: Icons.data_exploration_rounded,
                  data: 'Accident statistics'),
            ),
            const SizedBox(
              height: 20.0,
            ),
            GestureDetector(
                onTap: () {
                  Functions.showDialogFunction(
                    context: context,
                    data: 'Do you want to start a new chat?',
                    onTapYes: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(
                        builder: (context) =>Rooms(),
                      ));
                    },
                  );
                },
                child: const CardWidget(
                    icon: Icons.headset_mic, data: 'Start a live chat')),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    prefs!.clear();
                    Functions.showDialogFunction(
                      context: context,
                      data: 'Are you sure to logout?',
                      onTapYes: () {
                        Navigator.of(context, rootNavigator: true)
                            .push(
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                      },
                    );
                  },
                  child: Container(
                    width: 125.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.red.shade200,
                      borderRadius: BorderRadius.circular(25.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.shade200.withOpacity(0.6),
                          offset: const Offset(0.0, 1.0),
                          blurRadius: 0.5,
                          spreadRadius: 0.5,
                        ),
                      ],
                    ),
                    child: const Text(
                      'Logout',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
