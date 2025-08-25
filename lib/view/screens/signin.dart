import 'package:client_app/config/color.dart';
import 'package:client_app/controllers/auth_controller.dart';
import 'package:client_app/controllers/signin_controller.dart';
import 'package:client_app/view/widget/custom_input_container.dart';
import 'package:client_app/view/widget/custom_input_field.dart';
import 'package:client_app/view/widget/custom_phone_input.dart';
import 'package:client_app/view/widget/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final SigninController signinController = Get.put(SigninController());
  final AuthType authType = Get.find<AuthType>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          SizedBox(height: 10),
          _buildPhoneInput(),
          SizedBox(height: 10),
          _buildPasswordInput(),
          SizedBox(height: 20),
          _buildSignInButton(),
          _buildSwitchToSignUp(),
        ],
      ),
    );
  }

  /// Header text
  Widget _buildHeader() {
    return Text(
      'Please enter your credentials',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
    );
  }

  /// Phone input field
  Widget _buildPhoneInput() {
    return CustomInputContainer(
      inputTitle: "Mobile Number",
      inputWidget: CustomPhoneWidget(
        controller: phoneController,
        onchanged: (phone) {
          signinController.phone.value = phone.completeNumber;
        },
      ),
    );
  }

  /// Password input field
  Widget _buildPasswordInput() {
    return CustomInputContainer(
      inputTitle: "Enter password",
      inputWidget: CustomInputField(
        controller: passwordController,
        hintText: "Enter password",
        password: true,
        onChanged: (val) {
          signinController.password.value = val;
        },
      ),
    );
  }

  /// Sign In button
  Widget _buildSignInButton() {
    return CustomButton(
      buttonText: "Sign In",
      disabled: true, // Example: reactive state
      onTap: () {
        signIn();
      },
    );
  }

  /// Switch to Sign Up screen
  Widget _buildSwitchToSignUp() {
    return GestureDetector(
      onTap: () {
        authType.alterAuthenticationType();
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "New to CreditSea? Create an account",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: ColorX.backgroundBlue,
            ),
          ),
        ),
      ),
    );
  }

  /// Trigger sign in
  void signIn() async {
    signinController.phone.value = phoneController.text;
    signinController.password.value = passwordController.text;
    await signinController.signIn(context);
  }
}
