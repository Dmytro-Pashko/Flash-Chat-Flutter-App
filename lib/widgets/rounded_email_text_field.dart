import 'package:flutter/material.dart';

class RoundedEmailTextField extends StatelessWidget {
  const RoundedEmailTextField({
    Key? key,
    required this.label,
    required this.isEnabled,
    required this.onValueChanged,
  }) : super(key: key);

  final String label;
  final Function(String value) onValueChanged;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        focusColor: Colors.grey,
      ),
      child: TextField(
        enabled: isEnabled,
        onChanged: (value) {
          onValueChanged(value);
        },
        obscureText: false,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: label,
          alignLabelWithHint: true,
          prefixIcon: Icon(Icons.email),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          filled: true,
        ),
      ),
    );
  }
}
