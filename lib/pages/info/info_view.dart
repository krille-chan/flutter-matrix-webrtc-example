import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/l10n.dart';

import 'package:webrtc_flutter_matrix/pages/info/info_controller.dart';

class InfoView extends StatelessWidget {
  final InfoController controller;
  const InfoView(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(L10n.of(context)!.helloWorld),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Info'),
            leading: const Icon(Icons.info_outlined),
            onTap: controller.onInfoTab,
          ),
          ListTile(
            title: const Text('Logout'),
            leading: const Icon(Icons.logout_outlined),
            onTap: controller.onLogoutTab,
          ),
        ],
      ),
    );
  }
}
