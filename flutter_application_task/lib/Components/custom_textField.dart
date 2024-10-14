// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextfield extends StatelessWidget {
  final Widget? suffixIcon;
  final String labelText;
  final Color? textColor;
  final TextInputType? keyboard;
  final Function(String) onChanged;
  bool _isPasswordVisible = false;
  CustomTextfield(
      {super.key,
      required this.onChanged,
      required this.labelText,
      this.suffixIcon,
      this.textColor,
      this.keyboard});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onChanged: onChanged,
          keyboardType: keyboard ?? TextInputType.text,
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(
              color: textColor != null
                  ? textColor
                  : Color.fromARGB(255, 208, 19, 19),
            ),
            border: OutlineInputBorder(
              gapPadding: 6,
              borderSide: const BorderSide(
                color: Color.fromARGB(31, 243, 243, 243),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            suffixIcon: suffixIcon == null
                ? suffixIcon
                : IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromARGB(255, 57, 57, 57),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void setState(Null Function() param0) {}
}
