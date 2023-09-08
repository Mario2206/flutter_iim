import 'package:flutter/material.dart';
import 'package:rendu/models/User.dart';
import 'package:rendu/pages/user_information_page.dart';
import 'package:rendu/services/user_service.dart';
import 'package:rendu/utils/spacing.dart';
import 'package:rendu/utils/text_style.dart';
import 'package:rendu/widgets/user_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<dynamic> showAlertMessage(String message) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(message),
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'))
            ],
          );
        });
  }

  void navigateToHome(User user) {
    Navigator.pushNamed(context, '/home', arguments: HomePageArguments(user));
  }

  Future<void> authenticate() async {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      final authUser = await UserService.login(
          userNameController.text, passwordController.text);
      if (authUser != null) {
        navigateToHome(authUser);
      } else {
        showAlertMessage('Invalid credentials');
      }
    }
  }

  void signUp() {
    Navigator.pushNamed(context, '/register');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Center(
              child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                verticalSpace(50),
                Text("Let's sign you in.", style: titleStyle),
                verticalSpace(20),
                Text("Welcome back.", style: subtitleStyle),
                Text("You've been missed!", style: subtitleStyle),
                Image.asset('assets/login.jpg', height: 250),
                verticalSpace(20),
                UserForm(
                    formKey: formKey,
                    userNameController: userNameController,
                    passwordController: passwordController,
                    submit: authenticate),
                TextButton(
                    onPressed: signUp, child: Text("No account ? Sign up"))
              ],
            ),
          ))
        ],
      ),
    );
  }
}
