import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pollutrack/widgets/custom_plot.dart';
import 'package:pollutrack/widgets/score_circular_progress.dart';
import 'package:pollutrack/models/entities/entities.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../providers/home_provider.dart';

class Pollutants extends StatelessWidget {
  static const route = '/pollutants/';
  static const routeDisplayName = 'PollutantsPage';

  Pollutants({Key? key}) : super(key: key);
  DateTime day = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        // here we use a consumer to react to the changes in the provider, which are triggered by the notifyListener method
        child: Consumer<HomeProvider>(
          builder: (context, provider, child) => Column(
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
                      value: provider.aqi / 100,
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
                                  '${provider.aqi}',
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
                        DateTime day =
                            Provider.of<HomeProvider>(context, listen: false)
                                .showDate;
                        Provider.of<HomeProvider>(context, listen: false)
                            .getDataOfDay(
                                day.subtract(const Duration(days: 1)));
                      }),
                  Consumer<HomeProvider>(
                      builder: (context, value, child) => Text(
                          DateFormat('dd MMMM yyyy').format(value.showDate))),
                  IconButton(
                      icon: const Icon(Icons.navigate_next),
                      onPressed: () {
                        DateTime day =
                            Provider.of<HomeProvider>(context, listen: false)
                                .showDate;
                        Provider.of<HomeProvider>(context, listen: false)
                            .getDataOfDay(day.add(const Duration(days: 1)));
                      })
                ],
              ),
              Consumer<HomeProvider>(
                  builder: (context, value, child) =>
                      CustomPlot(data: _parseData(value.pm25)))
            ],
          ),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _parseData(List<PM25> data) {
    return data
        .map(
          (e) => {
            'date': DateFormat('HH:mm').format(e.dateTime),
            'points': e.value
          },
        )
        .toList();
  }
}
