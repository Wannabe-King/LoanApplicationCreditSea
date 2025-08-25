import 'package:flutter/material.dart';

class CustomInputContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final String inputTitle;
  final Widget inputWidget;

  const CustomInputContainer({
    super.key,
    this.width,
    required this.inputTitle,
    required this.inputWidget, this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              inputTitle,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 5,
            ),
            inputWidget,
            //       CustomPhoneWidget(onchanged:  (phone) {
            //   print(phone.completeNumber);
            // },),
            //       CustomInputField(hintText: "Please enter your mobile no.",)
          ],
        ));
  }
}