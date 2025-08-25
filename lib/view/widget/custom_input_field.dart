import 'package:creditsea_flutter_assignment/config/color.dart';
import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  final String hintText;
  final Function(String)? onChanged;
  final bool password;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final bool? autovalidate;

  const CustomInputField({
    super.key,
    required this.hintText,
    this.onChanged,
    required this.password,
    this.validator,
    required this.controller,
    this.suffixIcon,
    this.autovalidate,
  });

  static const inputBorder = OutlineInputBorder(
    borderSide: BorderSide(
      color: ColorX.darkGrey,
      width: 1.0,
    ),
  );

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  late bool obscured;

  @override
  void initState() {
    super.initState();
    obscured = widget.password;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        autovalidateMode: widget.autovalidate == true
            ? AutovalidateMode.onUserInteraction
            : null,
        controller: widget.controller,
        validator: widget.validator,
        obscureText: obscured,
        decoration: InputDecoration(
          border: CustomInputField.inputBorder,
          enabledBorder: CustomInputField.inputBorder,
          focusedBorder: CustomInputField.inputBorder,
          errorBorder: CustomInputField.inputBorder,
          hintText: widget.hintText,
          hintStyle: TextStyle(fontSize: 18),
          suffixIcon: widget.password
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      obscured = !obscured;
                    });
                  },
                  icon: Icon(obscured
                      ? Icons.remove_red_eye
                      : Icons.remove_red_eye_outlined))
              : widget.suffixIcon,
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}
