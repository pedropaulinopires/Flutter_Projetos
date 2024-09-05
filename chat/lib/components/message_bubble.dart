import 'dart:io';

import 'package:chat/core/models/chat_message.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  static const _defaultImage = 'assets/images/avatar.png';
  final ChatMessage chatMessage;
  final bool belongsToCurrentUser;

  const MessageBubble({
    super.key,
    required this.chatMessage,
    required this.belongsToCurrentUser,
  });

  Widget _showUserImage(String imageUrl) {
    ImageProvider? provider;
    final uri = Uri.parse(imageUrl);

    if (uri.path.contains(_defaultImage)) {
      provider = AssetImage(uri.toString());
    } else if (uri.scheme.contains('http') || uri.scheme.contains('https')) {
      provider = NetworkImage(uri.toString());
    } else {
      provider = FileImage(File(uri.toString()));
    }

    return CircleAvatar(
      backgroundColor: Colors.blue,
      backgroundImage: provider,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: belongsToCurrentUser
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
              decoration: BoxDecoration(
                  color:
                      belongsToCurrentUser ? Colors.grey.shade300 : Colors.blue,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(12),
                    topRight: const Radius.circular(12),
                    bottomLeft: belongsToCurrentUser
                        ? const Radius.circular(12)
                        : const Radius.circular(0),
                    bottomRight: belongsToCurrentUser
                        ? const Radius.circular(0)
                        : const Radius.circular(12),
                  )),
              width: 220,
              child: Column(
                crossAxisAlignment: belongsToCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    chatMessage.userName,
                    style: TextStyle(
                        color:
                            belongsToCurrentUser ? Colors.black : Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    chatMessage.text,
                    textAlign: belongsToCurrentUser ? TextAlign.right : TextAlign.start,
                    style: TextStyle(
                      color: belongsToCurrentUser ? Colors.black : Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
            top: 0,
            left: belongsToCurrentUser ? null : 205,
            right: belongsToCurrentUser ? 205 : null,
            child: _showUserImage(chatMessage.userImageUrl)),
      ],
    );
  }
}
