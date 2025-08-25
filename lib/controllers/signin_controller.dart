import 'dart:convert';
import 'package:creditsea_flutter_assignment/view/screens/personal_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class SigninController extends GetxController {
  var phone = ''.obs;
  var password = ''.obs;

  static final GetStorage _storage = GetStorage();

  Future<void> signIn(BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse('https://credit-sea-assignment-flutter-backend.onrender.com/api/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
            {'phoneNumber': '+91${phone.value}', 'password': password.value}),
      );
      print("signup called");
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        String token = data['token'];
        await _storage.write('auth_token', token);
        await _storage.write('phone', '+91${phone.value}');
        print('Login successful! Token: $token');
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => PersonalDetail()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login failed: ${response.body}')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Error occured while signup: ${e.toString()}")));
    }
  }
}
