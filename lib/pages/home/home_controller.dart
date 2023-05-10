import 'package:flutter/material.dart';
import 'package:webrtc_flutter_matrix/pages/home/home_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomeController();
}

/// Holds specific state and actions for this page to separate view and
/// controller on a low level base.
class HomeController extends State<HomePage> {
  @override
  Widget build(BuildContext context) => HomeView(this);
}
