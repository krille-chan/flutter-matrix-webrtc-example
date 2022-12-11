import 'package:flutter/material.dart';
import 'package:flutter_easy_template/config/app_constants.dart';
import 'package:flutter_easy_template/pages/info/info_view.dart';

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

  @override
  Widget build(BuildContext context) => InfoView(this);
}
