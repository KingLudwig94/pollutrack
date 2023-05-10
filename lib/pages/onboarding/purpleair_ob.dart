import 'package:flutter/material.dart';
import 'package:pollutrack/pages/home.dart';
import 'package:pollutrack/services/purpleair.dart';
import 'package:provider/provider.dart';

class PurpleAirOnboarding extends StatefulWidget {
  static const routeDisplayName = 'PurpleAirOnboardingPage';

  PurpleAirOnboarding({Key? key}) : super(key: key);

  @override
  State<PurpleAirOnboarding> createState() => _PurpleAirOnboardingState();
}

class _PurpleAirOnboardingState extends State<PurpleAirOnboarding> {
  final TextEditingController userController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<bool?> _contactPurpleAir(String apiKey, BuildContext context) async {
    PurpleAirService purpleAirService =
        Provider.of<PurpleAirService>(context, listen: false);
    bool logged = await purpleAirService.getAuth(apiKey);
    if (logged) {
      Future.delayed(
          const Duration(milliseconds: 100),
          () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const Home())));
    } else {
      return logged;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE4DFD4),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Image.asset('assets/PurpleAir_logo.png'),
              ),
              const Text('Please insert API Key to use our app',
                  style: TextStyle(
                    fontSize: 16,
                  )),
              const SizedBox(
                height: 20,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text('API Key',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(
                height: 7,
              ),
              TextFormField(
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'API Key is required';
                  }
                  return null;
                },
                controller: userController,
                cursorColor: const Color(0xFF83AA99),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color(0xFF89453C),
                    ),
                  ),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  prefixIcon: const Icon(
                    Icons.key,
                    color: Color(0xFF89453C),
                  ),
                  hintText: 'API Key',
                  hintStyle: const TextStyle(color: Color(0xFF89453C)),
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        bool? validation = await _contactPurpleAir(
                            userController.text, context);
                        if (validation != null) {
                          if (!validation) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.all(8),
                              content: Text('Wrong API Key'),
                              duration: Duration(seconds: 2),
                            ));
                          }
                        }
                      }
                    },
                    style: ButtonStyle(
                        //maximumSize: const MaterialStatePropertyAll(Size(50, 20)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                        elevation: MaterialStateProperty.all(0),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.symmetric(
                                horizontal: 80, vertical: 12)),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFF89453C))),
                    child: const Text('Authorize'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
