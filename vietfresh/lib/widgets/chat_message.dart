import 'package:chat_app/screen/auth.dart';

import 'package:chat_app/widgets/message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return StreamBuilder(
        stream: firestore
            .collection('chat')
            .orderBy('time', descending: true)
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
          final loadMessage = chatSnapshot.data!.docs;
          return ListView.builder(
              padding: const EdgeInsets.only(bottom: 40, left: 13, right: 13),
              reverse: true,
              itemCount: loadMessage.length,
              itemBuilder: (ctx, index) {
                final chatMessage = loadMessage[index].data();
                final nextChatMessage = index + 1 < loadMessage.length
                    ? loadMessage[index + 1].data()
                    : null;

                final currentUserChatId = chatMessage['userid'];
                final nextUserChatId =
                    nextChatMessage != null ? nextChatMessage['userid'] : null;
                final nextUserIsSame = nextUserChatId == currentUserChatId;

                if (nextUserIsSame) {
                  return MessageBubble.next(
                      message: chatMessage['text'],
                      isMe: user.uid == currentUserChatId);
                } else {
                  return MessageBubble.first(
                    userImage: chatMessage['userimage'],
                    username: chatMessage['username'],
                    message: chatMessage['text'],
                    isMe: user.uid == currentUserChatId,
                  );
                }
              });
        });
  }
}
