import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pollutrack/widgets/custom_plot.dart';
import 'package:pollutrack/widgets/score_circular_progress.dart';

import 'package:intl/intl.dart';

List<Map<String, dynamic>> data = [
  {'date': '2021-10-01', 'points': 1468},
  {'date': '2021-10-01', 'points': 1487},
  {'date': '2021-10-01', 'points': 1494},
  {'date': '2021-10-02', 'points': 1526},
  {'date': '2021-10-02', 'points': 1492},
  {'date': '2021-10-02', 'points': 1470},
  {'date': '2021-10-02', 'points': 1477},
  {'date': '2021-10-03', 'points': 1466},
  {'date': '2021-10-03', 'points': 1465},
  {'date': '2021-10-03', 'points': 1524},
  {'date': '2021-10-03', 'points': 1534},
  {'date': '2021-10-04', 'points': 1504},
  {'date': '2021-10-04', 'points': 1524},
  {'date': '2021-10-05', 'points': 1534},
  {'date': '2021-10-06', 'points': 1463},
  {'date': '2021-10-07', 'points': 1502},
  {'date': '2021-10-07', 'points': 1539},
  {'date': '2021-10-08', 'points': 1476},
  {'date': '2021-10-08', 'points': 1483},
  {'date': '2021-10-08', 'points': 1534},
  {'date': '2021-10-08', 'points': 1530},
  {'date': '2021-10-09', 'points': 1519},
  {'date': '2021-10-09', 'points': 1497},
  {'date': '2021-10-09', 'points': 1460},
  {'date': '2021-10-10', 'points': 1514},
  {'date': '2021-10-10', 'points': 1518},
  {'date': '2021-10-10', 'points': 1470},
  {'date': '2021-10-10', 'points': 1526},
  {'date': '2021-10-11', 'points': 1517},
  {'date': '2021-10-11', 'points': 1478},
  {'date': '2021-10-11', 'points': 1468},
  {'date': '2021-10-11', 'points': 1487},
  {'date': '2021-10-12', 'points': 1535},
  {'date': '2021-10-12', 'points': 1537},
  {'date': '2021-10-12', 'points': 1463},
  {'date': '2021-10-12', 'points': 1478},
  {'date': '2021-10-13', 'points': 1524},
  {'date': '2021-10-13', 'points': 1496},
  {'date': '2021-10-14', 'points': 1527},
  {'date': '2021-10-14', 'points': 1527},
];

class Pollutants extends StatefulWidget {
  static const route = '/pollutants/';
  static const routeDisplayName = 'PollutantsPage';

  const Pollutants({Key? key}) : super(key: key);

  @override
  State<Pollutants> createState() => _PollutantsState();
}

class _PollutantsState extends State<Pollutants> {
  int aqi = 10;
  DateTime day = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Air Pollution',
              style: TextStyle(
                  color: Color(0xFF83AA99),
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.ideographic,
              children: const [
                Icon(
                  MdiIcons.mapMarker,
                  color: Color(0xFF929497),
                ),
                Text('Padua, Italy',
                    style: TextStyle(fontSize: 18, color: Color(0xFF929497)))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Air Quality',
              style: TextStyle(
                  color: Color(0xFF89453C),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 150,
                height: 150,
                child: CustomPaint(
                  painter: ScoreCircularProgress(
                    backColor: const Color(0xFF89453C).withOpacity(0.4),
                    frontColor: const Color(0xFF89453C),
                    strokeWidth: 20,
                    value: aqi / 100,
                  ),
                  child: Align(
                      alignment: Alignment.center,
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.only(top: 40.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '$aqi',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Color(0xFF89453C)),
                              ),
                              const Text(
                                ' Not good',
                                style: TextStyle(fontSize: 16),
                              )
                            ]),
                      ))),
                ),
              ),
            ),
            const Text(
              'Daily Trend',
              style: TextStyle(
                  color: Color(0xFF89453C),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const Text('PM2.5 Concentration',
                style: TextStyle(fontSize: 14, color: Color(0xFF929497))),
            const SizedBox(
              height: 15,
            ),
            // Container(
            //   height: 300,
            //   width: 400,
            //   decoration: const BoxDecoration(
            //     borderRadius: BorderRadius.all(Radius.circular(10)),
            //   ),
            //   child: Column(
            //     children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    icon: const Icon(Icons.navigate_before),
                    onPressed: () {
                      setState(() {
                        day = day.subtract(const Duration(days: 1));
                      });
                    }),
                Text(DateFormat('dd MMMM yyyy').format(day)),
                IconButton(
                    icon: const Icon(Icons.navigate_next),
                    onPressed: () {
                      setState(() {
                        day = day.add(const Duration(days: 1));
                      });
                    })
              ],
            ),
            CustomPlot(data: data)
          ],
        ),
      ),
    );
  }
}
