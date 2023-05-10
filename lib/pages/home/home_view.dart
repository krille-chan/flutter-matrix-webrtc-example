import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';
import 'package:webrtc_flutter_matrix/config/app_constants.dart';
import 'package:webrtc_flutter_matrix/pages/home/home_controller.dart';

import '../../model/app_state.dart';

class HomeView extends StatelessWidget {
  final HomeController controller;
  const HomeView(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    final client = AppState.of(context).client;
    final rooms = client.rooms;
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.applicationName),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed('/info'),
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: StreamBuilder<Object>(
          stream: client.onSync.stream.where((s) => s.hasRoomUpdate),
          builder: (context, snapshot) {
            return ListView.builder(
              itemCount: rooms.length,
              itemBuilder: (context, i) {
                final room = rooms[i];
                final avatarUrl = rooms[i]
                    .avatar
                    ?.getThumbnail(
                      rooms[i].client,
                      width: 64,
                      height: 64,
                    )
                    .toString();
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        avatarUrl == null ? null : NetworkImage(avatarUrl),
                    child: avatarUrl == null ? const Text('#') : null,
                  ),
                  title: Row(
                    children: [
                      Expanded(child: Text(room.getLocalizedDisplayname())),
                      if (room.isUnreadOrInvited)
                        Material(
                          borderRadius: BorderRadius.circular(12),
                          color: Theme.of(context).colorScheme.primary,
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                room.notificationCount.toString(),
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  subtitle: Row(
                    children: [
                      Expanded(
                        child: FutureBuilder<String>(
                            future: room.lastEvent?.calcLocalizedBody(
                                  const MatrixDefaultLocalizations(),
                                  withSenderNamePrefix: true,
                                ) ??
                                Future.value('No message yet'),
                            builder: (context, snapshot) {
                              return Text(
                                snapshot.data ?? 'No messages yet',
                                maxLines: 1,
                              );
                            }),
                      ),
                      const SizedBox(width: 8),
                      Text(room.lastEvent?.originServerTs.localizedDay() ?? ''),
                    ],
                  ),
                  onTap: () =>
                      Navigator.of(context).pushNamed('/chat/${room.id}'),
                );
              },
            );
          }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Creating new chat...'),
          ));
          client.createRoom();
        },
        label: const Text('New Chat'),
        icon: const Icon(Icons.add_outlined),
      ),
    );
  }
}

extension on DateTime {
  String localizedDay() =>
      '${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}/$year';
}
