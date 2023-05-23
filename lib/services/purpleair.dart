import 'package:pollutrack/services/server_strings.dart';
import 'package:pollutrack/utils/shared_preferences.dart';
import 'package:dio/dio.dart';

class PurpleAirService {
  PurpleAirService(this.prefs);

  Preferences prefs;
  final Dio _dio = Dio(BaseOptions(
    baseUrl: ServerStrings.purpleAirUrl,
  ));

  Future<bool> getAuth(String apiKey) async {
    try {
      Response response = await _dio.get(ServerStrings.purpleAirApiAuthUrl,
          options: Options(headers: {'X-API-KEY': apiKey}));
      print(response);

      prefs.purpleAirXApiKey = apiKey;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // example of how to get the data from purpleair
  Future<Map<String, dynamic>> getData(String sensorIdx) async {
    String? xApiKey = prefs.purpleAirXApiKey;
    if (xApiKey != null) {
      try {
        Response response = await _dio.get(
            '${ServerStrings.purpleAirApiSesnorDataUrl}/$sensorIdx',
            options: Options(headers: {'X-API-KEY': xApiKey}));
        print(response);
        return response.data;
      } catch (e) {
        print(e);
        return {};
      }
    }
    return {};
  }

  // retrieve data from purple air API
  Future<Map<String, dynamic>> getHistoryData(
      String sensorIdx, DateTime startTime) async {
    try {
      Response response = await _dio.get(
          '${ServerStrings.purpleAirApiSesnorDataUrl}/$sensorIdx/history/?start_timestamp=${startTime.millisecondsSinceEpoch / 1000}&fields=pm2.5_atm',
          options: Options(headers: {'X-API-KEY': prefs.purpleAirXApiKey}));
      //print(response);
      return response.data;
    } catch (e) {
      print(e);
      return {};
    }
  }
}
