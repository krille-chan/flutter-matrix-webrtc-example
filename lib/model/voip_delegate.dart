import 'package:flutter/foundation.dart';

import 'package:flutter_webrtc/flutter_webrtc.dart' as webrtc_impl;
import 'package:matrix/matrix.dart';
import 'package:webrtc_interface/webrtc_interface.dart' hide Navigator;

class VoipDelegate implements WebRTCDelegate {
  @override
  MediaDevices get mediaDevices => webrtc_impl.navigator.mediaDevices;

  @override
  Future<webrtc_impl.RTCPeerConnection> createPeerConnection(
          Map<String, dynamic> configuration,
          [Map<String, dynamic> constraints = const {}]) =>
      webrtc_impl.createPeerConnection(configuration, constraints);
  @override
  webrtc_impl.VideoRenderer createRenderer() => webrtc_impl.RTCVideoRenderer();

  @override
  Future<void> playRingtone() async {
    // play ringtone
  }
  @override
  Future<void> stopRingtone() async {
    // stop ringtone
  }

  @override
  Future<void> handleNewCall(CallSession session) async {
    // handle new call incoming or outgoing
    switch (session.direction) {
      case CallDirection.kIncoming:
        // show incoming call window
        break;
      case CallDirection.kOutgoing:
        // show outgoing call window
        break;
    }
  }

  @override
  Future<void> handleCallEnded(CallSession session) async {
    // handle call ended by local or remote
  }

  @override
  // TODO: implement canHandleNewCall
  bool get canHandleNewCall => throw UnimplementedError();

  @override
  Future<void> handleGroupCallEnded(GroupCall groupCall) {
    // TODO: implement handleGroupCallEnded
    throw UnimplementedError();
  }

  @override
  Future<void> handleMissedCall(CallSession session) {
    // TODO: implement handleMissedCall
    throw UnimplementedError();
  }

  @override
  Future<void> handleNewGroupCall(GroupCall groupCall) {
    // TODO: implement handleNewGroupCall
    throw UnimplementedError();
  }

  @override
  // TODO: implement isWeb
  bool get isWeb => kIsWeb;
}
