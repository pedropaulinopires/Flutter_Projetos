import 'package:chat/core/services/auth/auth_service.dart';
import 'package:chat/core/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  String _message = '';
  final TextEditingController _controller = TextEditingController();

  Future<void> _sendMessage() async {
    final user = AuthService().getCurrentUser;

    if (user != null) {
      await ChatService().save(_message, user);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              onChanged: (msg) => setState(() => _message = msg),
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              decoration: const InputDecoration(
                labelText: 'Enviar mensagem...',
                contentPadding: EdgeInsets.all(15)
              ),
              onSubmitted: (_) => _sendMessage(),
              textInputAction: TextInputAction.send,
            ),
          ),
          IconButton(
              onPressed: _message.trim().isEmpty ? null : _sendMessage,
              icon: const Icon(Icons.send))
        ],
      ),
    );
  }
}
