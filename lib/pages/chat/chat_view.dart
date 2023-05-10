import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:matrix/matrix.dart';

import 'chat_controller.dart';

class ChatView extends StatelessWidget {
  final ChatController controller;
  const ChatView(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    final room = controller.widget.room;
    final callSession = controller.callSession;
    return Scaffold(
      appBar: AppBar(
        title: Text(room.getLocalizedDisplayname()),
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (callSession != null)
              Expanded(
                child: StreamBuilder<Object>(
                    stream: callSession.onCallStateChanged.stream,
                    builder: (context, _) {
                      return Column(
                        children: [
                          Text('State: ${callSession.state.name}'),
                          Expanded(
                            child: RTCVideoView(
                              // yes, it must explicitly be casted even though I do not feel
                              // comfortable with it...
                              callSession.streams.last.renderer
                                  as RTCVideoRenderer,
                              mirror: false,
                              objectFit: RTCVideoViewObjectFit
                                  .RTCVideoViewObjectFitContain,
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            Expanded(
              child: FutureBuilder(
                future: room.getTimeline(),
                builder: (context, snapshot) {
                  final timeline = snapshot.data;
                  if (timeline == null) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                    reverse: true,
                    itemCount: timeline.events.length,
                    itemBuilder: (context, i) {
                      final event = timeline.events[i];
                      return ListTile(
                        title: Text(
                            event.senderFromMemoryOrFallback.calcDisplayname()),
                        subtitle: Text(event.calcLocalizedBodyFallback(
                            const MatrixDefaultLocalizations())),
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                width: double.infinity,
                child: callSession == null
                    ? ElevatedButton.icon(
                        onPressed: controller.startCall,
                        label: const Text('Start videocall'),
                        icon: const Icon(Icons.video_call_outlined),
                      )
                    : ElevatedButton.icon(
                        onPressed: controller.stopCall,
                        label: const Text('Hangup'),
                        icon: const Icon(Icons.stop_outlined),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
