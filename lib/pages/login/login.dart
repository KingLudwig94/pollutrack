import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/shared_preferences.dart';
import '../onboarding/purpleair_ob.dart';

class Login extends StatefulWidget {
  static const route = '/login/';
  static const routeDisplayName = 'LoginPage';

  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  static bool _passwordVisible = false;
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final Preferences prefs = Preferences();
  void _showPassword() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE4DFD4),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFE4DFD4),
        title: const Text('PolluTrack',
            style: TextStyle(
                color: Color(0xFF83AA99),
                fontSize: 28,
                fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const Text('Login',
                  style: TextStyle(
                      color: Color(0xFF89453C),
                      fontSize: 28,
                      fontWeight: FontWeight.bold)),
              const Text('Please login to use our app',
                  style: TextStyle(
                    fontSize: 16,
                  )),
              const SizedBox(
                height: 20,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text('Username',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(
                height: 7,
              ),
              TextFormField(
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Username is required';
                  } else if (value != 'username') {
                    return 'Username is wrong';
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
                    Icons.person,
                    color: Color(0xFF89453C),
                  ),
                  hintText: 'Username',
                  hintStyle: const TextStyle(color: Color(0xFF89453C)),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text('Password',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(
                height: 7,
              ),
              TextFormField(
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  } else if (value != 'password') {
                    return 'Password is wrong';
                  }
                  return null;
                },
                controller: passwordController,
                cursorColor: const Color(0xFF83AA99),
                obscureText: !_passwordVisible,
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
                    Icons.lock,
                    color: Color(0xFF89453C),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      _showPassword();
                    },
                  ),
                  hintText: 'Password',
                  hintStyle: const TextStyle(color: Color(0xFF89453C)),
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        var prefs =
                            Provider.of<Preferences>(context, listen: false);
                        prefs.username = userController.text;
                        prefs.password = passwordController.text;
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => PurpleAirOnboarding()));
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
                    child: const Text('Log In'),
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
