import 'package:flutter/material.dart';
import 'package:webrtc_flutter_matrix/config/app_constants.dart';
import 'package:webrtc_flutter_matrix/pages/info/info_view.dart';

import '../../model/app_state.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => InfoController();
}

/// Holds specific state and actions for this page to separate view and
/// controller on a low level base.
class InfoController extends State<InfoPage> {
  void onInfoTab() => showAboutDialog(
        context: context,
        applicationName: AppConstants.applicationName,
      );

  void onLogoutTab() async {
    final navigator = Navigator.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Logging out...'),
      ),
    );
    await AppState.of(context).client.logout();
    navigator.pushNamedAndRemoveUntil('/login', (_) => false);
  }

  @override
  Widget build(BuildContext context) => InfoView(this);
}
