import 'package:flutter/material.dart';

import 'screens/chat_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const FlashChat());
}

class FlashChat extends StatelessWidget {
  const FlashChat({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      initialRoute: SplashScreen.screenId,
      routes: {
        SplashScreen.screenId: (context) => SplashScreen(),
        RegistrationScreen.screenId: (context) => RegistrationScreen(),
        LoginScreen.screenId: (context) => LoginScreen(),
        ChatScreen.screenId: (context) => ChatScreen()
      },
    );
  }
}
