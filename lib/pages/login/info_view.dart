import 'package:flutter/material.dart';

import 'info_controller.dart';

class LoginView extends StatelessWidget {
  final LoginController controller;
  const LoginView(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          TextField(
            readOnly: controller.loading,
            controller: controller.homeserverTextEditingController,
            decoration: const InputDecoration(
              labelText: 'Homeserver',
              hintText: 'Homeserver',
              prefixText: 'https://',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            readOnly: controller.loading,
            controller: controller.usernameTextEditingController,
            decoration: const InputDecoration(
              hintText: 'Username',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            readOnly: controller.loading,
            controller: controller.passwordTextEditingController,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Password',
              errorText: controller.errorText,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: controller.loading ? null : controller.loginAction,
            child: controller.loading
                ? const LinearProgressIndicator()
                : const Text('Login'),
          ),
        ],
      ),
    );
  }
}
