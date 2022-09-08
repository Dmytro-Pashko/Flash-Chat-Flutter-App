import 'package:flutter/material.dart';

import 'login_screen.dart';
import 'registration_screen.dart';
import 'splash_screen.dart';
import 'chat_screen.dart';

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
