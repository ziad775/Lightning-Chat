import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ligthning_chat/Screens/ScrnsWidgets/Rounded_buttons.dart';
import 'package:ligthning_chat/constants.dart';

class WlcmScrn extends StatelessWidget {
  const WlcmScrn({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome Screen'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Hero(
                    tag: "logo",
                    child: Image(
                      image: AssetImage('assets/thunder_icon.png'),
                    ),
                  ),
                  AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'Lightning Chat',
                        textStyle: TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Roboto",
                        ),
                        speed: const Duration(milliseconds: 500),
                      ),
                    ],
                  )
                  // const Text(
                  //   'Lightning Chat',
                  //   style: TextStyle(
                  //       fontSize: 38,
                  //       fontWeight: FontWeight.bold,
                  //       fontFamily: "Roboto"),
                  // ),
                ],
              ),
              const SizedBox(height: 20),
              RoundedButton(
                text: 'Login',
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                color: Colors.blueAccent,
              ),
              RoundedButton(
                text: "register",
                color: goldColor,
                onPressed: () {
                  Navigator.pushNamed(context, '/registration');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
