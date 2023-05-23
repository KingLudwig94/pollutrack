import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pollutrack/models/db.dart';
import 'package:pollutrack/services/impact.dart';
import 'package:pollutrack/services/purpleair.dart';
import 'package:pollutrack/services/server_strings.dart';
import 'package:pollutrack/utils/algorithm.dart';
import 'package:pollutrack/utils/shared_preferences.dart';

// this is the change notifier. it will manage all the logic of the home page: fetching the correct data from the database
// and on startup fetching the data from the online services
class HomeProvider extends ChangeNotifier {
  // data to be used by the UI
  late List<HR> heartRates;
  late List<Exposure> exposure;
  late List<PM25> pm25;
  late int aqi;
  late double fullexposure;
  late String exposurelevel;

  // data fetched from external services or db
  late List<HR> _heartRatesDB;
  late List<Exposure> _exposureDB;
  late List<PM25> _pm25DB;

  // selected day of data to be shown
  DateTime showDate = DateTime.now().subtract(const Duration(days: 1));

  // data generators faking external services
  final FitbitGen fitbitGen = FitbitGen();
  final PurpleAirGen purpleAirGen = PurpleAirGen();
  final Random _random = Random();

  final PurpleAirService purpleAir;
  DateTime lastFetch = DateTime.now().subtract(Duration(days: 2));
  final ImpactService impactService;

  bool doneInit = false;

  HomeProvider(this.purpleAir, this.impactService) {
    _init();
  }

  // constructor of provider which manages the fetching of all data from the servers and then notifies the ui to build
  Future<void> _init() async {
    await _fetchAndCalculate();
    getDataOfDay(showDate);
    doneInit = true;
    notifyListeners();
  }

  // method to fetch all data and calculate the exposure
  Future<void> _fetchAndCalculate() async {
    //_heartRatesDB = fitbitGen.fetchHR();
    // if (lastFetch.difference(DateTime.now()).inMinutes.abs() > 5) {
    //   _pm25DB = await _fetchPurpleAir(lastFetch);
    //   aqi = _calculateAqi().toInt();
    // }

    _heartRatesDB = await impactService.getDataFromDay(lastFetch);
    _pm25DB = await _fetchPurpleAir(lastFetch);
    aqi = _calculateAqi().toInt();
    _calculateExposure(_heartRatesDB, _pm25DB);
  }

  // method to trigger a new data fetching
  void refresh() {
    _fetchAndCalculate();
    getDataOfDay(showDate);
  }

  // method that implements the state of the art formula
  void _calculateExposure(List<HR> hr, List<PM25> pm25) {
    // _exposureDB = List.generate(
    //     100,
    //     (index) => Exposure(
    //         value: _heartRatesDB[index].value * _pm25DB[index].value,
    //         timestamp: DateTime.now().subtract(Duration(hours: index))));
    var vent = getMinuteVentilation(hr, 0);
    _exposureDB = getInhalation(vent, pm25);
  }

  // method to select only the data of the chosen day
  void getDataOfDay(DateTime showDate) {
    this.showDate = showDate;
    heartRates = _heartRatesDB
        .where((element) => element.timestamp.day == showDate.day)
        .toList()
        .reversed
        .toList();
    pm25 = _pm25DB
        .where((element) => element.timestamp.day == showDate.day)
        .toList()
        .reversed
        .toList();
    exposure = _exposureDB
        .where((element) => element.timestamp.day == showDate.day)
        .toList()
        .reversed
        .toList();
    fullexposure = exposure.map((e) => e.value).reduce(
          (value, element) => value + element,
        );
    if (fullexposure < 333) {
      exposurelevel = 'Low';
    } else if (fullexposure < 666) {
      exposurelevel = 'Medium';
    } else {
      exposurelevel = 'High';
    }
    // after selecting all data we notify all consumers to rebuild
    notifyListeners();
  }

  Future<List<PM25>> _fetchPurpleAir(DateTime startTime) async {
    final data = await purpleAir.getHistoryData(
        ServerStrings.sensorIdxMortise, startTime);
    final List<dynamic> pm25 = data['data'];
    List<PM25> out = pm25
        .map((e) => PM25(
            timestamp:
                DateTime.fromMillisecondsSinceEpoch((e[0] * 1000).toInt()),
            value: e[1]))
        .toList()
      ..sort(
        (a, b) => a.timestamp.compareTo(b.timestamp),
      );
    print(out);
    return out;
  }

  double _calculateAqi() {
    double value = _pm25DB.last.value;
    if (value <= 15) {
      return value / 15 * 25;
    } else if (value <= 30) {
      return (value - 15) / (30 - 15) * 25 + 25;
    } else if (value <= 55) {
      return (value - 30) / (55 - 30) * 25 + 50;
    } else if (value <= 110) {
      return (value - 55) / (110 - 55) * 25 + 75;
    } else {
      return 100;
    }
  }
}
