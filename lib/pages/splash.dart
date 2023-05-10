import 'package:flutter/material.dart';
import 'package:pollutrack/pages/home.dart';
import 'package:pollutrack/pages/login/login.dart';
import 'package:pollutrack/pages/onboarding/impact_ob.dart';
import 'package:pollutrack/services/impact.dart';
import 'package:pollutrack/utils/shared_preferences.dart';
import 'package:provider/provider.dart';

class Splash extends StatelessWidget {
  static const route = '/splash/';
  static const routeDisplayName = 'SplashPage';

  const Splash({Key? key}) : super(key: key);

  // Method for navigation SplashPage -> LoginPage
  void _toLoginPage(BuildContext context) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: ((context) => Login())));
  } //_toLoginPage

  // Method for navigation SplashPage -> HomePage
  void _toHomePage(BuildContext context) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: ((context) => Home())));
  } //_toHomePage

  // Method for navigation SplashPage -> HomePage
  void _toImpactPage(BuildContext context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: ((context) => ImpactOnboarding())));
  } //_toHomePage

  void _checkAuth(BuildContext context) async {
    //Preferences prefs = Preferences();
    var prefs = Provider.of<Preferences>(context, listen: false);
    String? username = prefs.username;
    String? password = prefs.password;

    if (username == null || password == null) {
      Future.delayed(const Duration(seconds: 1), () => _toLoginPage(context));
    } else {
      ImpactService service =
          Provider.of<ImpactService>(context, listen: false);
      bool responseAccessToken = await service.checkSavedToken();
      bool refreshAccessToken = await service.checkSavedToken(refresh: true);

      if (responseAccessToken) {
        Future.delayed(const Duration(seconds: 1), () => _toHomePage(context));
      } else if (refreshAccessToken) {
        Future.delayed(const Duration(seconds: 1), () => _toHomePage(context));
      } else {
        Future.delayed(
            const Duration(seconds: 1), () => _toImpactPage(context));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //Future.delayed(const Duration(seconds: 5), () => _toLoginPage(context));
    Future.delayed(const Duration(seconds: 1), () => _checkAuth(context));
    return Material(
      child: Container(
        color: const Color(0xFF83AA99),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const <Widget>[
            Text(
              'PolluTrack',
              style: TextStyle(
                  color: Color(0xFFE4DFD4),
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            Center(
              child: CircularProgressIndicator(
                strokeWidth: 4,
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF89453C)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
