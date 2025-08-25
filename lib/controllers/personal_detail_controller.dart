import 'dart:convert';
import 'dart:math';
import 'package:creditsea_flutter_assignment/view/widget/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

enum PersonalDetailScreen {
  name,
  email,
  pan,
}

class PersonalDetailController extends GetxController {
  var currentScreen = PersonalDetailScreen.name.obs;
  var firstName = ''.obs;
  var lastName = ''.obs;
  var gender = ''.obs;
  var maritialStatus = ''.obs;
  var dob = ''.obs;
  var otp = ''.obs;
  var email = ''.obs;
  var pan = ''.obs;

  static final GetStorage _storage = GetStorage();

  void pickDob(DateTime date) {
    dob.value = date.toIso8601String();
  }

  bool validateInputs() {
    if (firstName.value != '' &&
        lastName.value != '' &&
        gender.value != '' &&
        dob.value != '' &&
        maritialStatus.value != '') {
      return true;
    }
    return false;
  }

  void sendOtp(BuildContext context) {
    otp.value = generateOtp();
    showCustomDialog(
        context: context,
        title: "OTP Verification",
        description: "Your OTP for number ${email.value} is ${otp.value}");
  }

  String generateOtp() {
    Random random = Random();
    int otp = 100000 + random.nextInt(900000);
    return otp.toString();
  }

  void verifyOtp(String enteredOTP, BuildContext context) {
    if (enteredOTP == otp.value) {
      switchScreen(PersonalDetailScreen.pan);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please enter the correct otp.")));
    }
  }

  void switchScreen(PersonalDetailScreen screen) {
    currentScreen.value = screen;
  }

  void updateUserDetail(BuildContext context) async {
    var phone = _storage.read('phone');
    print(phone);
    var token = _storage.read('auth_token');
    print(token);
    final url = Uri.parse('https://credit-sea-assignment-flutter-backend.onrender.com/api/auth/update/$phone');

    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json', 'authorization': token},
        body: jsonEncode({
          'firstName': firstName.value,
          'lastName': lastName.value,
          'gender': gender.value,
          'maritialStatus': maritialStatus.value,
          'dob': dob.value,
          'otp': otp.value,
          'email': email.value,
          'pan': pan.value,
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User details updated successfully')),
        );
      } else {
        final errorMessage = jsonDecode(response.body)['message'] ??
            'Error updating user details';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: \$e')),
      );
    }
  }
}
