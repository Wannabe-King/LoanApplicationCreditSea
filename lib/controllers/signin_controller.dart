import 'dart:convert';
import 'package:client_app/view/pages/dashboard_page.dart';
import 'package:client_app/view/screens/personal_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SigninController extends GetxController {
  var phone = ''.obs;
  var password = ''.obs;

  static final GetStorage _storage = GetStorage();

  Future<void> signIn(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final response = await http.post(
        Uri.parse('https://creditseabackend-170m.onrender.com/api/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'phoneNumber': '+91${phone.value}',
          'password': password.value,
        }),
      );
      print("signup called");
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        String token = data['token'];
        prefs.setString('auth_token', token);
        prefs.setString('phone', '+91${phone.value}');
        await _storage.write('auth_token', token);
        await _storage.write('phone', '+91${phone.value}');
        print('Login successful! Token: $token');
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => DashboardPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error occured while signup: ${e.toString()}")),
      );
    }
  }
}
