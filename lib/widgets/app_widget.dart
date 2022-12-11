import 'package:flutter/material.dart';
import 'package:flutter_easy_template/config/app_constants.dart';
import 'package:flutter_easy_template/config/app_routes.dart';
import 'package:flutter_easy_template/model/app_state.dart';
import 'package:flutter_easy_template/model/app_storage.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class AppWidget extends StatelessWidget {
  final AppStorage storage;
  const AppWidget({required this.storage, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.applicationName,
      initialRoute: '/',
      onGenerateRoute: AppRoutes.onGenerateRoute,
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      builder: (_, child) => AppState(
        storage: storage,
        child: child ?? Container(),
      ),
    );
  }
}
