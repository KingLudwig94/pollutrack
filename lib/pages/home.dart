import 'package:flutter/material.dart';
import 'package:pollutrack/pages/info_exposure.dart';
import 'package:pollutrack/pages/info_pollutants.dart';
import 'package:pollutrack/pages/pollutants.dart';
import 'package:pollutrack/pages/profile.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selIdx = 0;

  void changePage(int index) {
    setState(() {
      _selIdx = index;
    });
  }

  Widget selectPage(int index) {
    switch (index) {
      case 0:
        return AirPollution();
      case 1:
        return PersonalExposure();
      default:
        return AirPollution();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 8),
          child: Column(
            children: [
              ListTile(
                leading: Icon(MdiIcons.logout),
                title: Text('Logout'),
                onTap: () {},
              ),
              Text('About'),
              ListTile(
                leading: Icon(MdiIcons.logout),
                title: Text('Personal Exposure Info'),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => InfoExposure()));
                },
              ),
              ListTile(
                leading: Icon(MdiIcons.logout),
                title: Text('Air Pollution Info'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => InfoPollutants()));
                },
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text('Pollutrack'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    fullscreenDialog: true, builder: (context) => Profile()));
              },
              icon: Icon(Icons.abc))
        ],
      ),
      body: selectPage(_selIdx),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selIdx,
        onTap: (value) {
          changePage(value);
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.abc), label: 'Air Pollution'),
          BottomNavigationBarItem(
              icon: Icon(Icons.abc), label: 'Personal Exposure'),
        ],
      ),
    );
  }
}

class PersonalExposure extends StatelessWidget {
  const PersonalExposure({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('Personal Exposure');
  }
}
