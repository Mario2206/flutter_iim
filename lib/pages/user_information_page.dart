import 'package:flutter/material.dart';
import 'package:rendu/models/user.dart';
import 'package:rendu/services/user_service.dart';
import 'package:rendu/utils/spacing.dart';
import 'package:rendu/utils/text_style.dart';
import 'package:rendu/widgets/user_form.dart';

class HomePageArguments {
  final User user;

  HomePageArguments(this.user);
}

class UserInformationPage extends StatefulWidget {
  const UserInformationPage({super.key});

  @override
  State<StatefulWidget> createState() => _UserInformationPageState();
}

class _UserInformationPageState extends State<UserInformationPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<User?> getData() async {
    final args =
        ModalRoute.of(context)!.settings.arguments as HomePageArguments;
    final userId = args.user.id;
    final user = await UserService.findById(userId);
    if (user != null) {
      userNameController.text = user.userName;
      passwordController.text = user.userPassword;
    }
    return user;
  }

  Future<dynamic> showAlertMessage(User user, bool isNewUser) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(isNewUser
                ? "New user created"
                : "Your profile has been updated"),
            content: Column(
              children: [
              Text("Username : ${user.userName}"),
              verticalSpace(20),
              Text("Password : ${user.userPassword}"),
            ]),
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

  Future<void> update() async {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      final args =
          ModalRoute.of(context)!.settings.arguments as HomePageArguments;
      final userId = args.user.id;
      final user = User(
          id: userId,
          userId: args.user.userId,
          userName: userNameController.text,
          userPassword: passwordController.text);
      await UserService.update(user);
      final updatedUser = await UserService.findById(userId);

      if (updatedUser != null) {
        showAlertMessage(updatedUser, false);
      }
    }
  }

  Future<void> register() async {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      final user = await UserService.register(
          userNameController.text, passwordController.text);
      if (user != null) {
        showAlertMessage(user, true);
      }
    }
  }

  @override
  Widget build(BuildContext buildContext) {
    return FutureBuilder(
        future: getData(),
        builder: (BuildContext buildContext, AsyncSnapshot<User?> snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final userId = snapshot.data!.userId;
          final userName = snapshot.data!.userName;
          final id = snapshot.data!.id;
          return Scaffold(
            appBar: AppBar(
              title: Text('Welcolme to $userName'),
            ),
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        'Hello $userName',
                        style: ThemeTextStyle.titleStyle,
                      ),
                      verticalSpace(20),
                      Row(
                        children: [
                          Text(
                            "User ID: $userId",
                            style: ThemeTextStyle.subtitleStyle,
                          )
                        ],
                      ),
                      verticalSpace(20),
                      Row(
                        children: [
                          Text(
                            "ID: $id",
                            style: ThemeTextStyle.subtitleStyle,
                          )
                        ],
                      ),
                      verticalSpace(20),
                      UserForm(
                          formKey: formKey,
                          userNameController: userNameController,
                          passwordController: passwordController,
                          buttonText: "Update",
                          submit: update),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange),
                              onPressed: register,
                              child: const Text(
                                "Register",
                                style: ThemeTextStyle.submitButtonStyle,
                              ))
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
