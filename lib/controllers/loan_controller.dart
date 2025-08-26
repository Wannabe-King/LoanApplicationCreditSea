import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoanController extends GetxController {
  var principalAmount = 0.obs;
  var tenure = 0.obs;
  var purpose = ''.obs;
  var totalAmount = 0.obs;

  Future<void> registerLoan(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    totalAmount =
        principalAmount + (principalAmount.value * 0.01 * tenure.value).toInt();
    final url = Uri.parse(
      'https://creditseabackend-170m.onrender.com/api/loan/create',
    );

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json', 'authorization': token},
        body: jsonEncode({
          'principal': principalAmount.value,
          'tenure': tenure.value,
          'purpose': purpose.value,
          'totalAmount': totalAmount.value,
        }),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Loan application created successfully'),
          ),
        );
      } else {
        final errorMessage =
            jsonDecode(response.body)['message'] ??
            'Failed to create loan application';
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(errorMessage)));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('An error occurred: $e')));
    }
  }
}
