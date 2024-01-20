import 'package:flutter/material.dart';

import '../widget/chat_message.dart';
import '../widget/new_message.dart';
import 'auth_admin.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key,required this.userId});
  final String userId;
  @override
  Widget build(BuildContext context) {
    final user= firebase.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trò chuyện'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(child: ChatMessage(userId: userId),),
          NewMessage(userId: userId,),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}