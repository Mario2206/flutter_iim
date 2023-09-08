import 'package:flutter/material.dart';
import 'package:rendu/utils/text_style.dart';

class UserForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController userNameController;
  final TextEditingController passwordController;
  final String buttonText;

  final void Function() submit;

  const UserForm(
      {super.key,
      required this.formKey,
      required this.userNameController,
      required this.passwordController,
      required this.submit,
      this.buttonText = "Login"});

  String? validatePassword(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a valid password';
    }
    return null;
  }

  String? validateUsername(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a valid username';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //////////////
            TextFormField(
              controller: userNameController,
              validator: validateUsername,
              decoration: const InputDecoration(
                  label: Text('Username'),
                  hintText: 'Enter your username',
                  hintStyle: TextStyle(color: Colors.blueGrey),
                  border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: passwordController,
              validator: validatePassword,
              obscureText: true,
              decoration: const InputDecoration(
                  label: Text('Password'),
                  hintText: 'Enter your password',
                  hintStyle: TextStyle(color: Colors.blueGrey),
                  border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: submit,
                child: Text(buttonText, style: ThemeTextStyle.submitButtonStyle)),
          ],
        ));
  }
}
