import 'package:flutter/material.dart';

class RoundedPasswordTextField extends StatelessWidget {
  const RoundedPasswordTextField({
    Key? key,
    required this.label,
    required this.isEnabled,
    required this.isShowValue,
    required this.onValueChanged,
    required this.onShowPasswordClicked,
  }) : super(key: key);

  final String label;
  final Function(String value) onValueChanged;
  final Function() onShowPasswordClicked;
  final bool isEnabled;
  final bool isShowValue;

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
        obscureText: !isShowValue,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          labelText: label,
          alignLabelWithHint: true,
          prefixIcon: Icon(Icons.lock),
          suffixIcon: GestureDetector(
            child: Icon(Icons.remove_red_eye),
            onTap: () {
              onShowPasswordClicked();
            },
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          filled: true,
        ),
      ),
    );
  }
}
