import 'package:flutter/material.dart';
import 'package:pollutrack/pages/splash.dart';
import 'package:pollutrack/services/impact.dart';
import 'package:pollutrack/services/purpleair.dart';
import 'package:pollutrack/utils/shared_preferences.dart';
import 'package:provider/provider.dart';

import 'models/db.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  runApp(Provider<AppDatabase>.value(value: db, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // we use the Multiprovider to inject all the app-wide services to the whole app. This way we will always use the same instance of the services without the need to reauthenticate
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => Preferences()..init(),
          // This creates the preferences when the provider is creater. With lazy = true (default), the preferences would be initialized when first accessed, but we need them for the other services
          lazy: false,
        ),
        Provider(
            create: (context) => ImpactService(
                  // We pass the newly created preferences to the service
                  Provider.of<Preferences>(context, listen: false),
                )),
        Provider(
            create: (context) => PurpleAirService(
                Provider.of<Preferences>(context, listen: false))),
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
