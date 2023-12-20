import 'package:chat_app/screen/auth.dart';
import 'package:chat_app/style.dart';
import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: firestore
            .collection('chat')
            .orderBy('time', descending: false)
            .snapshots(),
        builder: (ctx, chatSnapshot) {
          if (chatSnapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (!chatSnapshot.hasData || chatSnapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('Không có tin nhắn'),
            );
          }
          final chatMessage = chatSnapshot.data!.docs;
          return ListView.builder(
              itemCount: chatMessage.length,
              itemBuilder: (ctx, index) {
                return Style(outputText: chatMessage[index].data()['text']);
              });
        });
  }
}
