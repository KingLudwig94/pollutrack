import 'package:flutter/material.dart';
import 'package:pollutrack/widgets/custom_plot.dart';
import 'package:pollutrack/widgets/score_circular_progress.dart';
import 'package:pollutrack/models/db.dart' as db;
import '../../providers/home_provider.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Exposure extends StatelessWidget {
  static const route = '/exposure/';
  static const routeDisplayName = 'ExposurePage';

  Exposure({Key? key}) : super(key: key);

  double exposure = 2.5;
  DateTime day = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      // here we use a consumer to react to the changes in the provider, which are triggered by the notifyListener method
      child: Consumer<HomeProvider>(
        builder: (context, provider, child) => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Daily Personal Exposure',
              style: TextStyle(
                  color: Color(0xFF83AA99),
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Exposure Trend',
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
                    value: provider.fullexposure / 100,
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
                                '${provider.fullexposure}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Color(0xFF89453C)),
                              ),
                              const Text(
                                'Low',
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
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    icon: const Icon(Icons.navigate_before),
                    onPressed: () {
                      // here we use the access method to retrieve the Provider and use its values and methods
                      final provider =
                          Provider.of<HomeProvider>(context, listen: false);
                      DateTime day = provider.showDate;
                      provider
                          .getDataOfDay(day.subtract(const Duration(days: 1)));
                    }),
                Consumer<HomeProvider>(
                    builder: (context, value, child) => Text(
                        DateFormat('dd MMMM yyyy').format(value.showDate))),
                IconButton(
                    icon: const Icon(Icons.navigate_next),
                    onPressed: () {
                      final provider =
                          Provider.of<HomeProvider>(context, listen: false);
                      DateTime day = provider.showDate;
                      provider.getDataOfDay(day.add(const Duration(days: 1)));
                    })
              ],
            ),
            Consumer<HomeProvider>(
                builder: (context, value, child) =>
                    CustomPlot(data: _parseData(value.exposure)))
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _parseData(List<db.Exposure> data) {
    return data
        .map(
          (e) => {
            'date': DateFormat('HH:mm').format(e.timestamp),
            'points': e.value
          },
        )
        .toList();
  }
}
