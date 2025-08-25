import 'dart:math';
import 'package:creditsea_flutter_assignment/view/widget/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

enum SignUpScreen {
  phone,
  password,
  otp,
}

class SignupController extends GetxController {
  var currentScreen = SignUpScreen.phone.obs;
  var requestOtpEnabled = false.obs;
  var phoneNumber = ''.obs;
  var otp = ''.obs;
  var password = ''.obs;

  static final GetStorage _storage = GetStorage();

  void switchScreen(SignUpScreen screen) {
    currentScreen.value = screen;
  }

  void sendOtp(BuildContext context) {
    otp.value = generateOtp();
    showCustomDialog(
        context: context,
        title: "OTP Verification",
        description:
            "Your OTP for number ${phoneNumber.value} is ${otp.value}");
    switchScreen(SignUpScreen.otp);
  }

  String generateOtp() {
    Random random = Random();
    int otp = 1000 + random.nextInt(9000);
    return otp.toString();
  }

  void verifyOtp(String enteredOTP, BuildContext context) {
    if (enteredOTP == otp.value) {
      switchScreen(SignUpScreen.password);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please enter the correct otp.")));
    }
  }

  Future<bool> signUpUser(BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse(
            'https://credit-sea-assignment-flutter-backend.onrender.com/api/auth/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
            {'phoneNumber': phoneNumber.value, 'password': password.value}),
      );
      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        String token = data['token'];
        await _storage.write('auth_token', token);
        print('Signup successful! Token: $token');
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Signup failed: ${response.body}')));
        return false;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Error occured while signup: ${e.toString()}")));
      return false;
    }
  }
}
