import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:matrix/matrix.dart';
import 'package:webrtc_flutter_matrix/config/app_constants.dart';
import 'package:webrtc_flutter_matrix/widgets/app_widget.dart';

void main() async {
  log('Start app ${AppConstants.applicationName}...');
  WidgetsFlutterBinding.ensureInitialized();
  final client = Client(
    'Flutter WebRTC TestClient',
    databaseBuilder: (client) async {
      await Hive.initFlutter();
      // ignore: deprecated_member_use
      final db = FamedlySdkHiveDatabase(client.clientName);
      await db.open();
      return db;
    },
  );
  await client.init();
  runApp(AppWidget(client: client));
}
