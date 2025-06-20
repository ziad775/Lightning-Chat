import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ligthning_chat/Screens/ScrnsWidgets/Rounded_buttons.dart';
import 'ScrnsWidgets/text_input_Wiidget.dart';

class LoginScrn extends StatefulWidget {
  const LoginScrn({super.key});

  @override
  State<LoginScrn> createState() => _LoginScrnState();
}

class _LoginScrnState extends State<LoginScrn> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
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
        blurEffectIntensity: 4,
        dismissible: false,
        opacity: 0.4,
        progressIndicator: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
        ),
        color: Colors.white,
        inAsyncCall: showSpinner,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Login Screen'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: "logo",
                  child: Image(image: AssetImage('assets/thunder_icon.png')),
                ),
                const SizedBox(height: 20),
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
                  text: "Login",
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
                          await _auth.signInWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      if (userCredential.user != null) {
                        Navigator.pushNamed(context,
                            '/chat'); // Navigate to login screen after registration
                        setState(() {
                          showSpinner = false; // Hide spinner after processing
                        });
                      }
                    } catch (e) {
                      setState(() {
                        showSpinner = false; // Hide spinner after processing
                      });
                      print("Error: $e");
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
