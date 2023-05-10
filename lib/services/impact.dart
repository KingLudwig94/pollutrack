import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:dio/dio.dart';
import 'package:pollutrack/services/server_strings.dart';
import 'package:pollutrack/utils/shared_preferences.dart';

class ImpactService {
  ImpactService(this.prefs);
  Preferences prefs;
  
  final Dio _dio = Dio(BaseOptions(baseUrl: ServerStrings.backendBaseUrl));

  Future<String?> retrieveSavedToken(bool refresh) async {
    if (refresh) {
      return prefs.impactRefreshToken;
    } else {
      return prefs.impactAccessToken;
    }
  }

  Future<bool> checkSavedToken({bool refresh = false}) async {
    String? token = await retrieveSavedToken(refresh);
    //Check if there is a token
    if (token == null) {
      return false;
    }
    try {
      return ImpactService.checkToken(token);
    } catch (_) {
      return false;
    }
  }

  // this method is static because we might want to check the token outside the class itself
  static bool checkToken(String token) {
    //Check if the token is expired
    if (JwtDecoder.isExpired(token)) {
      return false;
    }

    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

    //Check the iss claim
    if (decodedToken['iss'] == null) {
      return false;
    } else {
      if (decodedToken['iss'] != ServerStrings.issClaim) {
        return false;
      } //else
    } //if-else

    //Check that the user is a patient
    if (decodedToken['role'] == null) {
      return false;
    } else {
      if (decodedToken['role'] != ServerStrings.patientRoleIdentifier) {
        return false;
      } //else
    } //if-else

    return true;
  } //checkToken

  Future<bool> getTokens(String username, String password) async {
    try {
      Response response = await _dio.post(
          '${ServerStrings.authServerUrl}token/',
          data: {'username': username, 'password': password},
          options: Options(
              contentType: 'application/json',
              followRedirects: false,
              validateStatus: (status) => true,
              headers: {"Accept": "application/json"}));

      if (ImpactService.checkToken(response.data['access']) &&
          ImpactService.checkToken(response.data['refresh'])) {
        prefs.impactRefreshToken = response.data['refresh'];
        prefs.impactAccessToken = response.data['refresh'];
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
