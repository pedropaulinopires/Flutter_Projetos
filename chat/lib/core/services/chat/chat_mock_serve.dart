import 'dart:async';
import 'dart:math';

import 'package:chat/components/chat_user.dart';
import 'package:chat/core/models/chat_message.dart';
import 'package:chat/core/services/chat/chat_service.dart';

class ChatMockServe implements ChatService {
  static final List<ChatMessage> _msgs = [
    ChatMessage(
      id: '1',
      text: 'Olá, seja bem vindo !',
      createdAt: DateTime.now(),
      userId: '1',
      userName: 'Pedro',
      userImageUrl: 'assets/images/avatar.png',
    ),
    ChatMessage(
      id: '2',
      text: 'Obrigado',
      createdAt: DateTime.now(),
      userId: '2',
      userName: 'Bia',
      userImageUrl: 'assets/images/avatar.png',
    ),
    ChatMessage(
      id: '3',
      text: 'Legal',
      createdAt: DateTime.now(),
      userId: '3',
      userName: 'Ana',
      userImageUrl: 'assets/images/avatar.png',
    ),
  ];
  static MultiStreamController<List<ChatMessage>>? _controller;
  static final _msgStreams = Stream<List<ChatMessage>>.multi((controller) {
    _controller = controller;
    _controller?.add(_msgs.reversed.toList());
  });

  @override
  Stream<List<ChatMessage>> messagesStream() => _msgStreams;

  @override
  Future<ChatMessage> save(String text, ChatUser user) async {
    final chatMessage = ChatMessage(
      id: Random().nextDouble().toString(),
      text: text,
      createdAt: DateTime.now(),
      userId: user.id,
      userName: user.name,
      userImageUrl: user.imageUrl,
    );

    _msgs.add(chatMessage);

    _controller?.add(_msgs.reversed.toList());

    return chatMessage;
  }
}
