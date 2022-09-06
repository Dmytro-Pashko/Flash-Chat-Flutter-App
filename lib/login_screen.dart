import 'package:flash_chat_flutter/registration_screen.dart';
import 'package:flash_chat_flutter/rounded_email_text_field.dart';
import 'package:flash_chat_flutter/rounded_password_text_field.dart';
import 'package:flash_chat_flutter/rounded_progress_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'auth.dart';

class LoginScreen extends StatefulWidget {
  static const String screenId = 'login_screen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final auth = AuthManager();

  String email = '';
  String password = '';
  bool isShowPassword = false;
  bool isLoading = false;
  String error = '';

  void signUp() async {
    setState(() {
      error = '';
      isLoading = true;
    });
    try {
      await auth.signIn(email, password);
      setState(() {
        isLoading = false;
      });
      //TODO go to chat screen.
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              getTopContent(),
              getCenterContent(),
              SizedBox(
                height: 40,
              ),
              getBottomContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget getTopContent() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 80),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
            tag: 'flash_icon',
            child: SvgPicture.asset(
              'assets/images/flash_icon.svg',
              width: 75,
            ),
          ),
          Text(
            'Flash Chat',
            style: TextStyle(
                fontSize: 40,
                color: Colors.black,
                fontFamily: 'Pacifico',
                fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }

  Widget getCenterContent() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Login',
            style: TextStyle(
                fontSize: 35, fontFamily: 'Anton', color: Colors.black),
          ),
          Text(
            'Please login to continue',
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'IBMPlexSans',
              color: (Color(0xFF595F67)),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 20),
              child: RoundedEmailTextField(
                label: 'Email,',
                isEnabled: !isLoading,
                onValueChanged: (value) {
                  email = value;
                },
              )),
          Padding(
              padding: const EdgeInsets.only(top: 20),
              child: RoundedPasswordTextField(
                label: 'password',
                isEnabled: !isLoading,
                isShowValue: isShowPassword,
                onValueChanged: (value) {},
                onShowPasswordClicked: () {
                  setState(() {
                    isShowPassword = !isShowPassword;
                  });
                },
              )),
          SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            height: 60,
            child: RoundedProgressButton(
              label: 'Login',
              isInProgress: isLoading,
              onClick: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget getBottomContent() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            textAlign: TextAlign.center,
            'Don\'t have an account?',
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'IBMPlexSans',
              color: (Color(0xFF595F67)),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 60,
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.screenId);
              },
              child: Text(
                'Create Account',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: 'IBMPlexSans',
                ),
              ),
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
