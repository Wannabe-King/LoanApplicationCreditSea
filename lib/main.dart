
import 'package:client_app/view/screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static final GetStorage _storage = GetStorage();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var auth_token = MyApp._storage.read('auth_token');
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CreditSea',
      theme: ThemeData(
          primaryColor: Colors.blue.shade200,
          colorScheme: ColorScheme.fromSwatch(
            backgroundColor: Colors.blue.shade200,
            primarySwatch: Colors.blue,
          ),
          datePickerTheme: DatePickerThemeData(
              backgroundColor: Colors.blue.shade50.withValues(alpha: 0.9)),
          scaffoldBackgroundColor: Colors.blue.shade100),
      debugShowCheckedModeBanner: false,
      home: const SignInPage(),
    );
  }
}
