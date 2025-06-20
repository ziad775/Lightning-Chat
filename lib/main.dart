import 'package:flutter/material.dart';
import 'package:ligthning_chat/Screens/chat_scrn.dart';
import 'package:ligthning_chat/Screens/login_scrn.dart';
import 'package:ligthning_chat/Screens/registration_scrn.dart';
import 'Screens/wlcm_scrn.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(LightningChat());
}

class LightningChat extends StatelessWidget {
  LightningChat({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WlcmScrn(),
        '/chat': (context) => const ChatScrn(),
        '/login': (context) => const LoginScrn(),
        '/registration': (context) => const RegistrationScrn(),
      },
    );
  }
}
