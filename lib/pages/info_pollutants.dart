import 'package:flutter/material.dart';

class InfoPollutants extends StatelessWidget {
  const InfoPollutants({Key? key}) : super(key: key);

  static const route = '/infopollutants/';
  static const routename = 'InfoPollutantsPage';

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
                    'Air Pollution',
                    style: TextStyle(
                        color: Color(0xFF83AA99),
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Air Quality',
                    style: TextStyle(
                        color: Color(0xFF89453C),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                      'The Index is based on concentration values for up to five key pollutants, including particulate matter (PM10), fine particulate matter (PM2.5), ozone (O3); nitrogen dioxide (NO2); sulphur dioxide (SO2). It reflects the potential impact of air quality on health, driven by the pollutant for which concentrations are poorest due to associated health impacts.'),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Airborne Particulate Matter',
                    style: TextStyle(
                        color: Color(0xFF89453C),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                      'Particulate matter (PM) components include fineley divided solids or liquids such as dust, pollen, fly ash, soot, smoke, aerosols, fumes, mists and condensing vapours that can be suspended in the air for extended periods of time.')
                ]),
          )),
        ));
  } //build
} //Page