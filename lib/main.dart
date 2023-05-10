import 'package:flutter/material.dart';
import 'package:pollutrack/pages/splash.dart';
import 'package:pollutrack/services/impact.dart';
import 'package:pollutrack/services/purpleair.dart';
import 'package:pollutrack/utils/shared_preferences.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => Preferences()..init(),
          lazy: false,
        ),
        Provider(
            create: (context) => ImpactService(
                Provider.of<Preferences>(context, listen: false))),
        Provider(
            create: (context) => PurpleAirService(
                Provider.of<Preferences>(context, listen: false)))
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Splash(),
      ),
    );
  }
}
