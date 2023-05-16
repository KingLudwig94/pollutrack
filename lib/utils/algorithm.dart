import 'dart:math';

import 'package:pollutrack/models/db.dart';

List<Ventilation> getMinuteVentilation(List<HR> heartrate, int gender) {
  // double sumheart = 0;
  // for (int p = 0; p < heartrates.length; p++) {
  //   sumheart = sumheart + heartrates[p].value;
  // }

  // double valheart =
  //     double.parse((sumheart / heartrates.length).toStringAsFixed(2));
  List<Ventilation> vent = [];
  for (HR hr in heartrate) {
    int valheart = hr.value;

    if (valheart != 0) {
      if (gender == 1) {
        // UOMO
        double val = pow(e, 1.03 + (0.021 * valheart)) as double;
        vent.add(Ventilation(hr.timestamp, val));
      } else {
        // DONNA
        double val = pow(e, 0.57 + (0.023 * valheart)) as double;
        vent.add(Ventilation(hr.timestamp, val));
      }
    }
  }
  return vent;
}

List<Exposure> getInhalation(
    List<Ventilation> minuteVentilation, List<PM25> pms) {
  List<Exposure> exposure = [];

  for (PM25 pm in pms) {
    // heart rates sampling rate is 1 minute, pms sampling rate is 10 minutes.
    // Extract the mean value of heart rate in the 10 minutes before of a pm data point
    List<Ventilation> tmp = minuteVentilation
        .where((element) =>
            element.timestamp.difference(pm.timestamp) >
                const Duration(minutes: -10) &&
            element.timestamp.difference(pm.timestamp) <= Duration.zero)
        .toList();

    if (tmp.isNotEmpty) {
      double tmpMean =
          tmp.map((e) => e.vent).reduce((value, element) => value + element) /
              tmp.length;

      exposure.add(Exposure(
          timestamp: pm.timestamp, value: tmpMean * pm.value * 10 / 1000));
    }
  }

// db dao
  return exposure;
}

class Ventilation {
  DateTime timestamp;
  double vent;
  Ventilation(this.timestamp, this.vent);
}
