import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatefulWidget {
  static const String screenId = 'login_screen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              SizedBox(height: 40,),
              getBottomContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget getTopContent() {
    return Expanded(
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
                fontSize: 35, fontFamily: 'IBMPlexSans', color: Colors.black),
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
            child: Theme(
              data: ThemeData(
                primaryColor: Colors.black,
                selectedRowColor: Colors.black,
                focusColor: Colors.grey,
              ),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  alignLabelWithHint: true,
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  filled: true,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Theme(
              data: ThemeData(
                primaryColor: Colors.black,
                selectedRowColor: Colors.black,
                focusColor: Colors.grey,
              ),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'password',
                  alignLabelWithHint: true,
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  filled: true,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            height: 60,
            child: TextButton(
              onPressed: () {},
              child: Text(
                'Login ',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: 'IBMPlexSans',
                ),
              ),
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.black),
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
              onPressed: () {},
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
