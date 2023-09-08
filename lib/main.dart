import 'package:flutter/material.dart';
import 'package:rendu/database/DatabaseConnection.dart';
import 'package:rendu/pages/user_information_page.dart';
import 'package:rendu/pages/login_page.dart';
import 'package:rendu/pages/register_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseConnection.connect();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Rendu",
      home: const Scaffold(
        body: const LoginPage(),
      ),
      routes: {
        '/register': (context) => const RegisterPage(),
        '/home':(context) => const UserInformationPage()
      },
    );
  }
}
