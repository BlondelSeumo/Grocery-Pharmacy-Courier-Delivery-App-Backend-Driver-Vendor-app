import 'package:firebase_chat/firebase_chat.dart';
import 'package:firebase_chat/models/chat_entity.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/widgets/chat.view.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({
    this.chatEntity,
    Key key,
  }) : super(key: key);

  final ChatEntity chatEntity;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          chatEntity.title,
        ),
      ),
      body: ChatBody(
        entity: chatEntity,
      ).wFull(context),
    );
  }
}
