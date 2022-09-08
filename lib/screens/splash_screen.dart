import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String screenId = 'splash_screen';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  static const int durationMs = 1500;

  late AnimationController animationController;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();

    animationController = AnimationController(
      duration: Duration(milliseconds: durationMs),
      vsync: this,
    );
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.elasticOut);

    animationController.forward();
    animationController.addListener(() {
      setState(() {});
    });

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacementNamed(context, LoginScreen.screenId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'flash_icon',
              child: SvgPicture.asset(
                'assets/images/flash_icon.svg',
                width: 200.0 * animation.value,
              ),
            ),
            AnimatedTextKit(
              animatedTexts: [
                TyperAnimatedText(
                  'Flash Chat',
                  textStyle: TextStyle(
                      fontSize: 50,
                      color: Colors.black,
                      fontFamily: 'Pacifico',
                      fontWeight: FontWeight.normal),
                  speed: Duration(milliseconds: 100),
                )
              ],
              totalRepeatCount: 1,
            )
          ],
        ),
      ),
    );
  }
}
