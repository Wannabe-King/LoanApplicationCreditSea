import 'package:client_app/view/pages/dashboard_page.dart';
import 'package:client_app/view/screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<bool> validToken;
  @override
  void initState() {
    validToken = isValid();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CreditSea',
      theme: ThemeData(
        datePickerTheme: DatePickerThemeData(
          backgroundColor: Colors.blue.shade50.withValues(alpha: 0.9),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<bool>(
        future: validToken,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || !(snapshot.data ?? false)) {
            return SignInPage();
          } else {
            return DashboardPage();
          }
        },
      ),
    );
  }

  Future<bool> isValid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final authToken = prefs.getString('auth_token');
    final phoneNumber = prefs.getString('phone');
    final url = Uri.parse(
      'https://creditseabackend-170m.onrender.com/api/auth/user/$phoneNumber',
    );
    final response = await http.get(
      url,
      headers: {'authorization': authToken ?? ''},
    );
    print(response.body);
    return response.statusCode == 200;
  }
}
