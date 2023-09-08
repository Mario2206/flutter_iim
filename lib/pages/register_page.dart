import 'package:flutter/material.dart';
import 'package:rendu/services/user_service.dart';
import 'package:rendu/utils/spacing.dart';
import 'package:rendu/utils/text_style.dart';
import 'package:rendu/widgets/user_form.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void navigateToLogin() {
    Navigator.pop(context);
  }

  Future<void> register() async {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      await UserService.register(userNameController.text, passwordController.text);
      navigateToLogin();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(children: [
        Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [
              verticalSpace(50),
              Text("Let's sign up.", style: titleStyle),
              verticalSpace(20),
              Image.asset('assets/register.jpg', height: 250),
              verticalSpace(20),
              UserForm(
                formKey: formKey,
                userNameController: userNameController,
                passwordController: passwordController,
                submit: register,
                buttonText: "Register",
              )
            ]),
          )
      ],),
    );
  }
}
