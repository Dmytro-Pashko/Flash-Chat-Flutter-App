import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RoundedProgressButton extends StatelessWidget {
  const RoundedProgressButton({
    Key? key,
    this.isInProgress,
    required this.onClick,
    required this.label,
  }) : super(key: key);

  final isInProgress;
  final Function() onClick;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      child: TextButton(
        onPressed: isInProgress
            ? null
            : () async {
                onClick();
              },
        child: isInProgress
            ? SpinKitFadingCircle(
                color: Colors.white,
                size: 50,
              )
            : Text(
                label,
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
            backgroundColor: isInProgress? Colors.grey[800] : Colors.black),
      ),
    );
  }
}
