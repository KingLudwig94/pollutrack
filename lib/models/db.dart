import 'dart:math';

class HR {
  // this class models the single heart rate data point
  final DateTime timestamp;
  final int value;

  HR({required this.timestamp, required this.value});
}

class PM25 {
  // this class models the single PM2.5 data point
  final DateTime timestamp;
  final double value;

  PM25({required this.timestamp, required this.value});
}

class Exposure {
  // this class models the single calculated exposure value
  final DateTime timestamp;
  final double value;

  Exposure({required this.timestamp, required this.value});
}

class FitbitGen {
  final Random _random = Random();

  List<HR> fetchHR() {
    return List.generate(
        100,
        (index) => HR(
            timestamp: DateTime.now().subtract(Duration(hours: index)),
            value: _random.nextInt(180)));
  }
}

class PurpleAirGen {
  final Random _random = Random();
  List<PM25> fetchPM() {
    return List.generate(
        100,
        (index) => PM25(
            timestamp: DateTime.now().subtract(Duration(hours: index)),
            value: _random.nextDouble() * 150));
  }
}
