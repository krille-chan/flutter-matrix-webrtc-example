import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';
import 'package:webrtc_flutter_matrix/config/app_constants.dart';
import 'package:webrtc_flutter_matrix/config/app_routes.dart';
import 'package:webrtc_flutter_matrix/model/app_state.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class AppWidget extends StatelessWidget {
  final Client client;
  const AppWidget({required this.client, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.applicationName,
      theme: ThemeData(useMaterial3: true),
      onGenerateRoute: AppRoutes(client).onGenerateRoute,
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      builder: (_, child) => AppState(
        client: client,
        child: child ?? Container(),
      ),
    );
  }
}
