import 'package:chat/components/messages.dart';
import 'package:chat/components/new_message.dart';
import 'package:chat/core/services/auth/auth_service.dart';
import 'package:chat/core/services/notification/chat_notification_service.dart';
import 'package:chat/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pires chat'),
          actions: [
            DropdownButtonHideUnderline(
              child: DropdownButton(
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'logout',
                    child: Row(
                      children: [
                        Icon(
                          Icons.exit_to_app,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Sair')
                      ],
                    ),
                  )
                ],
                onChanged: (value) {
                  if (value == 'logout') {
                    AuthService().logout();
                  }
                },
              ),
            ),
            Consumer<ChatNotificationService>(
              builder: (context, providerNotification, child) => Stack(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pushNamed(AppRoutes.notifications),
                    icon: const Icon(Icons.notifications),
                  ),
                  if (providerNotification.item.isNotEmpty)
                    Positioned(
                      top: 1,
                      right: 3,
                      child: CircleAvatar(
                        maxRadius: 10,
                        backgroundColor: Colors.red,
                        child: Text(
                          '${providerNotification.item.length}',
                          style: const TextStyle(
                              fontSize: 12, color: Colors.white),
                        ),
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
        body: const SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Messages(),
                ),
              ),
              NewMessage(),
            ],
          ),
        ));
  }
}
