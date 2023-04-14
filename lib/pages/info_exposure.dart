import 'package:flutter/material.dart';

class InfoExposure extends StatelessWidget {
  const InfoExposure({Key? key}) : super(key: key);

  static const route = '/infoexposure/';
  static const routename = 'InfoExposurePage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFE4DFD4),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFFE4DFD4),
          iconTheme: const IconThemeData(color: Color(0xFF89453C)),
          title: const Text('About', style: TextStyle(color: Colors.black)),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Personal Exposure',
                    style: TextStyle(
                        color: Color(0xFF83AA99),
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Daily Inhalation',
                    style: TextStyle(
                        color: Color(0xFF89453C),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                      'Exposure assessment refers to the process of estimating or measuring the magnitude, frequency, and duration of an individual’s exposure to a particular agent. Accurate quantification of everyday human exposure to air pollution is necessary for health risk assessments.'),
                ]),
          )),
        ));
  } //build
} //Page