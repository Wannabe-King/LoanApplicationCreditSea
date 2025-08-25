import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoanApplication {
  final String loanType;
  final String status;
  final String amount;
  final String tenure;

  LoanApplication({
    required this.loanType,
    required this.status,
    required this.amount,
    required this.tenure,
  });

  factory LoanApplication.fromJson(Map<String, dynamic> json) {
    return LoanApplication(
      loanType: json['purpose'] ?? '',
      status: json['applicationStatus'] ?? '',
      amount: json['principal'].toString(),
      tenure: json['tenure'].toString(),
    );
  }
}

class LoanApplicationController extends GetxController {
  var applications = <LoanApplication>[].obs;
  var isLoading = false.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  //   fetchApplications(); // ✅ only once when controller is created
  // }

  Future<void> fetchApplications() async {
    isLoading.value = true;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    final phone = prefs.getString('phone');
    final url = Uri.parse(
      'https://creditseabackend-170m.onrender.com/api/loan/user/$phone',
    );

    try {
      final response = await http.get(
        url,
        headers: {'authorization': token ?? ''},
      );
      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body)['loans'] ?? [];
        applications.value = data
            .map((e) => LoanApplication.fromJson(e))
            .toList();
      } else {
        applications.value = [];
      }
    } catch (e) {
      applications.value = [];
    }
    isLoading.value = false;
  }

  void logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('auth_token');
  }
}
