import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pollutrack/pages/login/login.dart';
import 'package:pollutrack/pages/pollutants.dart';
import 'package:pollutrack/pages/profile.dart';
import 'package:pollutrack/pages/exposure.dart';
import 'package:pollutrack/pages//info_exposure.dart';
import 'package:pollutrack/pages/info_pollutants.dart';
import 'package:pollutrack/providers/home_provider.dart';
import 'package:pollutrack/services/impact.dart';
import 'package:pollutrack/services/purpleair.dart';
import 'package:pollutrack/services/server_strings.dart';
import 'package:pollutrack/utils/shared_preferences.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  static const route = '/home/';
  static const routeDisplayName = 'HomePage';

  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selIdx = 0;

  List<BottomNavigationBarItem> navBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(MdiIcons.imageFilterDrama),
      label: 'Air Pollution',
    ),
    const BottomNavigationBarItem(
      icon: Icon(MdiIcons.dotsHexagon),
      label: 'Personal Exposure',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selIdx = index;
    });
  }

  Widget _selectPage({
    required int index,
  }) {
    switch (index) {
      case 0:
        return Pollutants();
      case 1:
        return Exposure();
      default:
        return Pollutants();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeProvider>(
      create: (context) => HomeProvider(
          Provider.of<PurpleAirService>(context, listen: false),
          Provider.of<ImpactService>(context, listen: false)),
      builder: (context, child) => Scaffold(
          backgroundColor: const Color(0xFFE4DFD4),
          drawer: Drawer(
            child: ListView(
              children: [
                ListTile(
                    leading: const Icon(MdiIcons.logout),
                    title: const Text('Logout'),
                    // delete all data from the preferences
                    onTap: () async {
                      bool reset = await Preferences().resetSettings();
                      if (reset) {
                        Navigator.of(context).pushReplacementNamed(Login.route);
                      }
                    }),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('About'),
                ),
                ListTile(
                    leading: const Icon(MdiIcons.imageFilterDrama),
                    title: const Text('Pollution Information'),
                    onTap: () => {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => InfoPollutants(),
                          ))
                        }),
                ListTile(
                    leading: const Icon(MdiIcons.dotsHexagon),
                    title: const Text('Exposure Information'),
                    onTap: () => {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => InfoExposure(),
                          ))
                        }),
              ],
            ),
          ),
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Color(0xFF89453C)),
            elevation: 0,
            backgroundColor: const Color(0xFFE4DFD4),
            actions: [
              IconButton(
                  padding: const EdgeInsets.only(left: 8.0, top: 8, bottom: 8),
                  onPressed: () async {
                    Provider.of<HomeProvider>(context, listen: false).refresh();

                    //Let's test and get some data for now in the UI
                    //TODO: remove this and move in the provider
                    // PurpleAirService purpleAirService =
                    //     Provider.of<PurpleAirService>(context, listen: false);
                    // Preferences prefs =
                    //     Provider.of<Preferences>(context, listen: false);
                    // bool auth = false;
                    // String? apiKey = prefs.purpleAirXApiKey;
                    // if (apiKey != null) {
                    //   auth = await purpleAirService.getAuth(apiKey);
                    // }
                    // if (auth) {
                    //   // Purple Air data fetch
                    //   Map<String, dynamic> response = await purpleAirService
                    //       .getData(ServerStrings.sensorIdxMortise);
                    //   print(response["sensor"]["pm10.0"]);
                    // }
                  },
                  icon: const Icon(
                    MdiIcons.downloadCircle,
                    size: 30,
                    color: Color(0xFF89453C),
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              fullscreenDialog: true,
                              builder: (context) => Profile()));
                    },
                    icon: const Icon(
                      MdiIcons.accountCircle,
                      size: 40,
                      color: Color(0xFF89453C),
                    )),
              )
            ],
          ),
          body: Provider.of<HomeProvider>(context).doneInit
              ? _selectPage(index: _selIdx)
              : const Center(
                  child: CircularProgressIndicator(),
                ) /* _selectPage(index: _selIdx) */,
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: const Color(0xFF83AA99),
            selectedItemColor: const Color(0xFF89453C),
            items: navBarItems,
            currentIndex: _selIdx,
            onTap: _onItemTapped,
          )),
    );
  }
}
