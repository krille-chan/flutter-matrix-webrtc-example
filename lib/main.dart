import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easy_template/config/app_constants.dart';
import 'package:flutter_easy_template/model/app_storage.dart';
import 'package:flutter_easy_template/widgets/app_widget.dart';

void main() async {
  log('Start app ${AppConstants.applicationName}...');
  final storage = await AppStorage.init();
  runApp(AppWidget(storage: storage));
}
