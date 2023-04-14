import 'package:flutter/material.dart';
import 'package:pollutrack/pages/home.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  void _toHomePage(BuildContext context) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () => _toHomePage(context));
    return Material(
      child: Container(
        color: const Color(0xFF83AA99),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Pollutrack',
                style: TextStyle(
                    color: Color(0xFFE4DFD4),
                    fontSize: 40,
                    fontWeight: FontWeight.bold)),
            CircularProgressIndicator(
                strokeWidth: 4,
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF89453C)))
          ],
        ),
      ),
    );
  }
}
