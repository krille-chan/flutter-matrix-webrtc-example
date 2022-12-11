import 'package:flutter/material.dart';
import 'package:flutter_easy_template/config/app_constants.dart';
import 'package:flutter_easy_template/logic/counter_actions.dart';
import 'package:flutter_easy_template/pages/home/home_controller.dart';
import 'package:flutter_easy_template/logic/app_state.dart';

class HomeView extends StatelessWidget {
  final HomeController controller;
  const HomeView(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.applicationName),
      ),
      body: Center(
        child: ValueListenableBuilder(
          valueListenable: AppState.of(context).counter,
          builder: (context, value, _) => Text(value.toString()),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: AppState.of(context).increaseCounter,
        child: const Icon(Icons.add),
      ),
    );
  }
}
