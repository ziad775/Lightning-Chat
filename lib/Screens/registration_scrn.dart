import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ligthning_chat/Screens/ScrnsWidgets/Rounded_buttons.dart';
import 'package:ligthning_chat/Screens/ScrnsWidgets/text_input_Wiidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';

class RegistrationScrn extends StatefulWidget {
  const RegistrationScrn({super.key});

  @override
  State<RegistrationScrn> createState() => _RegistrationScrnState();
}

class _RegistrationScrnState extends State<RegistrationScrn> {
  final _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool showSpinner = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlurryModalProgressHUD(
        inAsyncCall: showSpinner,
        blurEffectIntensity: 4,
        progressIndicator: const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
        ),
        dismissible: false,
        opacity: 0.4,
        color: Colors.white,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Registration Screen'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: "logo",
                  child: Image(
                    image: AssetImage('assets/thunder_icon.png'),
                  ),
                ),
                TextInputWidget(
                  controller: _emailController,
                  textInputType: TextInputType.emailAddress,
                  labelText: "Email",
                  hintText: "Enter your Email",
                  prefixIcon: Icon(Icons.email),
                  onChanged: (value) {
                    // Handle email input changes if needed
                  },
                ),
                TextInputWidget(
                  controller: _passwordController,
                  textInputType: TextInputType.visiblePassword,
                  labelText: "Password",
                  hintText: "Enter your Password",
                  prefixIcon: Icon(Icons.password),
                  onChanged: (value) {
                    // Handle email input changes if needed
                  },
                  isPassword: true, // Set to true for password input
                ),
                RoundedButton(
                  text: "register",
                  color: Colors.blueAccent,
                  onPressed: () async {
                    setState(() {
                      showSpinner = true; // Show spinner while processing
                    });
                    // Handle registration logic here
                    String email = _emailController.text;
                    String password = _passwordController.text;
                    // You can add your registration logic here
                    try {
                      final UserCredential userCredential =
                          await _auth.createUserWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      if (userCredential.user != null) {
                        Navigator.pushNamed(
                          context,
                          '/chat',
                        ); // Navigate to login screen after registration
                        setState(() {
                          showSpinner = false; // Hide spinner after processing
                        });
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
