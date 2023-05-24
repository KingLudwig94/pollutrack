import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pollutrack/models/db.dart';
import 'package:pollutrack/models/entities/entities.dart';
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
  final AppDatabase db;

  // data fetched from external services
  late List<HR> _heartRates;
  late List<Exposure> _exposure;
  late List<PM25> _pm25;

  // selected day of data to be shown
  DateTime showDate = DateTime.now().subtract(const Duration(days: 1));

  final PurpleAirService purpleAir;
  late DateTime lastFetch;
  final ImpactService impactService;

  bool doneInit = false;

  HomeProvider(this.purpleAir, this.impactService, this.db) {
    _init();
  }

  // constructor of provider which manages the fetching of all data from the servers and then notifies the ui to build
  Future<void> _init() async {
    await _fetchAndCalculate();
    await getDataOfDay(showDate);
    doneInit = true;
    notifyListeners();
  }

  Future<DateTime?> _getLastFetch() async {
    var data = await db.exposuresDao.findAllExposures();
    if (data.isEmpty) {
      return null;
    }
    return data.last.dateTime;
  }

  // method to fetch all data and calculate the exposure
  Future<void> _fetchAndCalculate() async {
    lastFetch = await _getLastFetch() ??
        DateTime.now().subtract(const Duration(days: 2));
    // do nothing if already fetched
    if (lastFetch.day == DateTime.now().subtract(const Duration(days: 1)).day) {
      return;
    }
    _heartRates = await impactService.getDataFromDay(lastFetch);
    for (var element in _heartRates) {
      db.heartRatesDao.insertHeartRate(element);
    } // db add to the table

    _pm25 = await _fetchPurpleAir(lastFetch);
    for (var element in _pm25) {
      db.pmsDao.insertPm(element);
    } // db add to the table

    aqi = _calculateAqi(_pm25.last.value).toInt();
    _calculateExposure(_heartRates, _pm25);
  }

  // method to trigger a new data fetching
  Future<void> refresh() async {
    await _fetchAndCalculate();
    await getDataOfDay(showDate);
  }

  // method that implements the state of the art formula
  void _calculateExposure(List<HR> hr, List<PM25> pm25) {
    var vent = getMinuteVentilation(hr, 0);
    _exposure = getInhalation(vent, pm25);
    for (var element in _exposure) {
      db.exposuresDao.insertExposure(element);
    } // db add to the table
  }

  // method to select only the data of the chosen day
  Future<void> getDataOfDay(DateTime showDate) async {
    // check if the day we want to show has data
    var firstDay = await db.exposuresDao.findFirstDayInDb();
    var lastDay = await db.exposuresDao.findLastDayInDb();
    if (showDate.isAfter(lastDay!.dateTime) ||
        showDate.isBefore(firstDay!.dateTime)) return;
        
    this.showDate = showDate;
    heartRates = await db.heartRatesDao.findHeartRatesbyDate(
        DateUtils.dateOnly(showDate),
        DateTime(showDate.year, showDate.month, showDate.day, 23, 59));
    pm25 = await db.pmsDao.findPmsbyDate(DateUtils.dateOnly(showDate),
        DateTime(showDate.year, showDate.month, showDate.day, 23, 59));
    exposure = await db.exposuresDao.findExposuresbyDate(
        DateUtils.dateOnly(showDate),
        DateTime(showDate.year, showDate.month, showDate.day, 23, 59));
    fullexposure = exposure.map((e) => e.value).reduce(
          (value, element) => value + element,
        );
    aqi = _calculateAqi(pm25.last.value).toInt();

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
              null,
              e[1],
              DateTime.fromMillisecondsSinceEpoch((e[0] * 1000).toInt()),
            ))
        .toList();
    print(out);
    return out;
  }

  double _calculateAqi(double value) {
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
