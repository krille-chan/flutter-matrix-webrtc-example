import 'package:flutter/material.dart';

import 'package:matrix/matrix.dart';

import '../../model/app_state.dart';
import 'login_view.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginController();
}

/// Holds specific state and actions for this page to separate view and
/// controller on a low level base.
class LoginController extends State<LoginPage> {
  final TextEditingController homeserverTextEditingController =
      TextEditingController();
  final TextEditingController usernameTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();

  bool loading = false;
  String? errorText;

  void loginAction() async {
    final homeserver = homeserverTextEditingController.text;
    final username = usernameTextEditingController.text;
    final password = passwordTextEditingController.text;

    if (homeserver.isEmpty || username.isEmpty || password.isEmpty) {
      setState(() {
        errorText = 'Please fill out all textfields.';
      });
      return;
    }

    setState(() {
      loading = true;
      errorText = null;
    });

    final navigator = Navigator.of(context);

    try {
      final client = AppState.of(context).client;
      await client.checkHomeserver(Uri.https(homeserver));
      await client.login(
        LoginType.mLoginPassword,
        identifier: AuthenticationUserIdentifier(user: username),
        password: password,
      );
      navigator.pushReplacementNamed('/');
    } catch (e) {
      setState(() {
        loading = false;
        errorText = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) => LoginView(this);
}
