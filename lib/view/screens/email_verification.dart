import 'package:creditsea_flutter_assignment/config/assets.dart';
import 'package:creditsea_flutter_assignment/controllers/personal_detail_controller.dart';
import 'package:creditsea_flutter_assignment/view/widget/custom_input_container.dart';
import 'package:creditsea_flutter_assignment/view/widget/custom_input_field.dart';
import 'package:creditsea_flutter_assignment/view/widget/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({super.key});

  @override
  State<EmailVerification> createState() => _PersonalDetailState();
}

class _PersonalDetailState extends State<EmailVerification> {
  final TextEditingController emailController = TextEditingController();
  final PersonalDetailController personalDetailController =
      Get.find<PersonalDetailController>();
  final List<TextEditingController> _otpControllers =
      List.generate(6, (_) => TextEditingController());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => personalDetailController
                  .switchScreen(PersonalDetailScreen.name),
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              "Personal Details",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Image.asset(Assets.email),
        SizedBox(
          height: 20,
        ),
        CustomInputContainer(
          height: 100,
          inputTitle: "Email ID*",
          inputWidget: CustomInputField(
            autovalidate: true,
            validator: (value) {
              if (value != null && value != '') {}
              return null;
            },
            suffixIcon: IconButton(
              icon: Icon(Icons.send_rounded),
              onPressed: () {
                final bool emailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(emailController.text);
                if (!emailValid) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please enter valid email")));
                } else {
                  personalDetailController.email.value = emailController.text;
                  personalDetailController.sendOtp(context);
                }
              },
            ),
            controller: emailController,
            hintText: "Enter your email ID",
            password: false,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        CustomInputContainer(
          inputTitle: "OTP Verification",
          inputWidget: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(6, (index) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                width: 50,
                child: TextFormField(
                  controller: _otpControllers[index],
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  maxLength: 1,
                  decoration: InputDecoration(
                    counterText: '',
                    filled: true,
                    fillColor: const Color(0xFFF3F8FF),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(color: Color(0xFFD9D9D9)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(color: Color(0xFF1573FE)),
                    ),
                  ),
                  onChanged: (value) {
                    print('$index' + "lets start" + value);
                    if (value.length == 1 && index < 5) {
                      FocusScope.of(context).nextFocus();
                    } else if (value.isEmpty && index > 0) {
                      FocusScope.of(context).previousFocus();
                    }
                  },
                ),
              );
            }),
          ),
        ),
        Spacer(),
        CustomButton(
          buttonText: "Verify",
          disabled: true,
          onTap: () {
            var enteredOTP = _otpControllers[0].text +
                _otpControllers[1].text +
                _otpControllers[2].text +
                _otpControllers[3].text +
                _otpControllers[4].text +
                _otpControllers[5].text;
            personalDetailController.verifyOtp(enteredOTP, context);
            personalDetailController.switchScreen(PersonalDetailScreen.pan);
          },
        )
      ],
    );
  }
}
