import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../widgets/custom_plot.dart';
import '../widgets/score_circular_progress.dart';

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

class AirPollution extends StatelessWidget {
  const AirPollution({super.key});

  final aqi = 80;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Air Pollution'),
        Row(
          children: [Icon(MdiIcons.mapMarker), Text('Padua, Italy')],
        ),
        Text('Air Quality'),
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
        Text('Daily Trend'),
        Text('PM2.5 Concentration'),
        Row(
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.keyboard_arrow_left)),
            Text('${DateFormat('dd MM yyyy').format(DateTime.now())}'),
            IconButton(onPressed: () {}, icon: Icon(Icons.keyboard_arrow_right))
          ],
        ),
        CustomPlot(data: data)
      ],
    );
  }
}
