import 'package:flash_chat_flutter/rounded_email_text_field.dart';
import 'package:flash_chat_flutter/rounded_password_text_field.dart';
import 'package:flash_chat_flutter/rounded_progress_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'auth.dart';

class RegistrationScreen extends StatefulWidget {
  static const String screenId = 'registration_screen';

  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final auth = AuthManager();

  bool isLoading = false;
  bool isShowPassword = false;
  String email = '';
  String password = '';
  String error = '';

  void signUp() async {
    setState(() {
      error = '';
      isLoading = true;
    });
    try {
      await auth.signUp(email, password);
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
                height: 80,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getTopContent() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100),
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
            'Sign Up',
            style: TextStyle(
                fontSize: 35, fontFamily: 'Anton', color: Colors.black),
          ),
          Text(
            'Sign up to get started.',
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'IBMPlexSans',
              color: (Color(0xFF595F67)),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 20),
              child: RoundedEmailTextField(
                label: 'Email',
                isEnabled: !isLoading,
                onValueChanged: (value) {
                  email = value;
                },
              )),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: RoundedPasswordTextField(
              onValueChanged: (value) {
                password = value;
              },
              label: 'password',
              isEnabled: !isLoading,
              isShowValue: isShowPassword,
              onShowPasswordClicked: () {
                setState(() {
                  isShowPassword = !isShowPassword;
                });
              },
            ),
          ),
          SizedBox(
            height: 40,
          ),
          RoundedProgressButton(
            onClick: () {
              signUp();
            },
            label: 'Create Account',
            isInProgress: isLoading,
          ),
          SizedBox(
            height: 40,
          ),
          error.isNotEmpty
              ? Text(
                  error,
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    fontFamily: 'IBMPlexSans',
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
