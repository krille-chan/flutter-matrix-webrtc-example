import 'package:flutter/material.dart';

import 'package:matrix/matrix.dart';

import '../../model/app_state.dart';
import 'chat_view.dart';

class ChatPage extends StatefulWidget {
  final Room room;
  const ChatPage({super.key, required this.room});

  @override
  State<ChatPage> createState() => ChatController();
}

/// Holds specific state and actions for this page to separate view and
/// controller on a low level base.
class ChatController extends State<ChatPage> {
  CallSession? callSession;

  void startCall() async {
    final voip = AppState.of(context).voip;
    final callSession =
        await voip.inviteToCall(widget.room.id, CallType.kVideo);
    callSession.onCallStateChanged.stream
        .where((s) => s == CallState.kEnded)
        .listen((_) => setState(() {
              this.callSession = null;
            }));
    setState(() {
      this.callSession = callSession;
    });
  }

  void stopCall() async {
    final callSession = this.callSession!;
    setState(() {
      if (callSession.isRinging) {
        callSession.reject();
      } else {
        callSession.hangup();
      }
    });
  }

  @override
  Widget build(BuildContext context) => ChatView(this);
}
