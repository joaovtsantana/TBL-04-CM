
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/message_model.dart';
import '../models/conversation_model.dart';

class ChatProvider extends ChangeNotifier {

  final Uuid uuid = const Uuid();

  final List<ConversationModel> conversations = [
    ConversationModel(
      id: '1',
      name: 'João',
      lastMessage: 'Olá!',
    ),
    ConversationModel(
      id: '2',
      name: 'Maria',
      lastMessage: 'Tudo bem?',
    ),
  ];

  final List<MessageModel> messages = [];

  Timer? timer;

  bool isUpdating = false;

  String? activeConversationId;

  void sendMessage(String conversationId, String text) {

    if (text.trim().isEmpty) return;

    final message = MessageModel(
      id: uuid.v4(),
      conversationId: conversationId,
      sender: 'Eu',
      text: text.trim(),
      createdAt: DateTime.now(),
    );

    messages.add(message);

    updateLastMessage(conversationId, text.trim());

    notifyListeners();
  }

  List<MessageModel> getMessages(String conversationId) {
    return messages
        .where((message) =>
            message.conversationId == conversationId)
        .toList();
  }

  void updateLastMessage(String id, String text) {

    final index = conversations.indexWhere(
      (conversation) => conversation.id == id,
    );

    if (index != -1) {
      conversations[index].lastMessage = text;
    }
  }

  void receiveFakeMessage(String conversationId) {

    final message = MessageModel(
      id: uuid.v4(),
      conversationId: conversationId,
      sender: 'João',
      text: 'Mensagem automática recebida!',
      createdAt: DateTime.now(),
    );

    messages.add(message);

    updateLastMessage(conversationId, message.text);

    notifyListeners();
  }

  void startUpdating(String conversationId) {

    if (isUpdating &&
        activeConversationId == conversationId) {
      return;
    }

    stopUpdating();

    isUpdating = true;
    activeConversationId = conversationId;

    timer = Timer.periodic(
      const Duration(seconds: 5),
      (_) {
        receiveFakeMessage(conversationId);
      },
    );
  }

  void stopUpdating() {

    timer?.cancel();

    timer = null;

    isUpdating = false;
    activeConversationId = null;
  }

  @override
  void dispose() {
    stopUpdating();
    super.dispose();
  }
}
