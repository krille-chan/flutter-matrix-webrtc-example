import 'package:flutter/material.dart';
import 'package:flutter_easy_template/pages/info/info_controller.dart';

class InfoView extends StatelessWidget {
  final InfoController controller;
  const InfoView(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Info'),
            leading: const Icon(Icons.info_outlined),
            onTap: controller.onInfoTab,
          ),
        ],
      ),
    );
  }
}
