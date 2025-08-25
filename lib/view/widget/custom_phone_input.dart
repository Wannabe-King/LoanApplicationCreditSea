import 'package:creditsea_flutter_assignment/config/color.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class CustomPhoneWidget extends StatelessWidget {
  final Function(PhoneNumber)? onchanged;
  final TextEditingController controller;

  const CustomPhoneWidget({
    super.key,
    this.onchanged, required this.controller,
  });

  static const inputBorder = OutlineInputBorder(
    borderSide: BorderSide(
      color: ColorX.lightGrey,
      width: 1.0,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      controller: controller,
      flagsButtonPadding: const EdgeInsets.all(8),
      dropdownIconPosition: IconPosition.trailing,
      decoration: const InputDecoration(
        border: inputBorder,
        enabledBorder: inputBorder,
        focusedBorder: inputBorder,
        errorBorder: inputBorder,
        hintText: "Please enter your mobile no.",
        hintStyle: TextStyle(fontSize: 18, color: ColorX.lightGrey),
      ),
      initialCountryCode: 'IN',
      onChanged: onchanged,
    );
  }
}
