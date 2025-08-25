import 'package:client_app/config/color.dart';
import 'package:client_app/controllers/auth_controller.dart';
import 'package:client_app/controllers/signup_controller.dart';
import 'package:client_app/view/widget/custom_input_container.dart';
import 'package:client_app/view/widget/custom_input_field.dart';
import 'package:client_app/view/widget/custom_phone_input.dart';
import 'package:client_app/view/widget/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpFlow extends StatefulWidget {
  const SignUpFlow({super.key});

  @override
  State<SignUpFlow> createState() => _SignUpFlowState();
}

class _SignUpFlowState extends State<SignUpFlow> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController reenterController = TextEditingController();
  final List<TextEditingController> _otpControllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final SignupController signupController = Get.put(SignupController());
  final AuthType authType = Get.find<AuthType>();
  bool agree = false;
  @override
  Widget build(BuildContext context) {
    return Obx(() => _buildCurrentScreen(signupController.currentScreen.value));
  }

  Widget _buildCurrentScreen(SignUpScreen screen) {
    switch (screen) {
      case SignUpScreen.phone:
        return _buildsignUp();
      case SignUpScreen.password:
        return _buildPassword();
      case SignUpScreen.otp:
        return _buildOtp();
    }
  }

  Widget _buildOtp() {
    return Column(
      children: [
        // // OTP screen starts from here
        Row(
          children: [
            Text(
              'Enter OTP',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          "Verify OTP, Sent on ${signupController.phoneNumber.value}",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(4, (index) {
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
                  if (value.length == 1 && index < 3) {
                    FocusScope.of(context).nextFocus();
                  } else if (value.isEmpty && index > 0) {
                    FocusScope.of(context).previousFocus();
                  }
                },
              ),
            );
          }),
        ),
        Text(
          "00:20",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 50),
        CustomButton(
          buttonText: "Verify",
          disabled: true,
          onTap: () {
            var enteredOTP =
                _otpControllers[0].text +
                _otpControllers[1].text +
                _otpControllers[2].text +
                _otpControllers[3].text;
            signupController.verifyOtp(enteredOTP, context);
          },
        ),
      ],
    );
  }

  Widget _buildsignUp() {
    return Column(
      children: [
        // Mobile phone screen starts from here
        Text(
          'Welcome to Credit Sea!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 10),
        CustomInputContainer(
          inputTitle: "Mobile Number",
          inputWidget: CustomPhoneWidget(
            controller: phoneController,
            onchanged: (phone) {
              if (phoneController.text.length == 10) {
                signupController.phoneNumber.value = phone.completeNumber;
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Checkbox(
                activeColor: ColorX.green,
                value: agree,
                onChanged: (value) {
                  setState(() {
                    agree = value ?? false;
                  });
                },
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  "By continuing, you agree to our privacy policies and Terms & Conditions.",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
        ),
        CustomButton(
          buttonText: "Request OTP",
          disabled: agree,
          onTap: () {
            if (phoneController.text.length == 10) {
              signupController.sendOtp(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Please Enter a valid number")),
              );
            }
          },
        ),
        GestureDetector(
          onTap: () {
            authType.alterAuthenticationType();
          },
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Existing User? Sign in",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: ColorX.backgroundBlue,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPassword() {
    return Column(
      children: [
        // Password setting screen starts here
        Text(
          'Create a password',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 10),
        CustomInputContainer(
          inputTitle: "Enter password",
          inputWidget: CustomInputField(
            controller: passwordController,
            hintText: "Enter password",
            password: true,
          ),
        ),
        SizedBox(height: 10),
        CustomInputContainer(
          inputTitle: "Re enter password",
          inputWidget: CustomInputField(
            controller: reenterController,
            hintText: "Re enter password",
            password: true,
          ),
        ),
        SizedBox(height: 10),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Text(
            "*your password must include 6 characters, inclusive of at least 1 special character",
            style: TextStyle(fontSize: 15),
          ),
        ),
        SizedBox(height: 20),
        CustomButton(
          buttonText: "Proceed",
          disabled: true,
          onTap: () {
            if (passwordController.text.length < 6) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Password must be at least 6 characters"),
                ),
              );
            } else {
              if (passwordController.text != reenterController.text) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Passwords do not match")),
                );
              } else {
                signUp();
              }
            }
          },
        ),
      ],
    );
  }

  void signUp() async {
    signupController.password.value = passwordController.text;
    var success = await signupController.signUpUser(context);
    if (success == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Registration Successful. Please signIn to continue."),
        ),
      );
      authType.alterAuthenticationType();
      setState(() {
        agree = !agree;
      });
    }
  }
}
