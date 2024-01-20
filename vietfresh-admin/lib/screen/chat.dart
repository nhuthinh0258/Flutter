import 'package:admin/screen/auth_admin.dart';
import 'package:admin/screen/chat_screen.dart';
import 'package:admin/style.dart';
import 'package:admin/style2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final firebase = FirebaseAuth.instance;

class Chats extends StatelessWidget {
  const Chats({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trò chuyện'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: firestore.collection('chat').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Không có cuộc trò chuyện nào.'));
          }

          final chatList = snapshot.data!.docs;

          return ListView.builder(
            itemCount: chatList.length,
            itemBuilder: (context, index) {
              final chatData = chatList[index].data();
              final userId = chatData['userid'];
              final lastMessage = chatData['lastMessage'];

              return FutureBuilder(
                  future: firestore
                      .collection('users')
                      .where('user_id', isEqualTo: userId)
                      .get(),
                  builder: (ctx, userSnapshot) {
                    if (userSnapshot.connectionState == ConnectionState.done &&
                        userSnapshot.hasData) {
                      final userData = userSnapshot.data!.docs;
                      final user = userData.first.data();
                      final userImage =
                          user['image']; // Khai báo userImage ở đây
                      ImageProvider avatar;
                      if (userImage != null) {
                        avatar = NetworkImage(userImage);
                      } else {
                        avatar =
                            const AssetImage('assets/images/VietFresh.png');
                      }
                      return InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (ctx) {
                            return ChatScreen(userId: userId);
                          }));
                        },
                        child: Card(
                          color: Theme.of(context).primaryColorLight,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: ListTile(
                                leading: CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      avatar, // Sử dụng avatar ở đây
                                ),
                                title: Style(outputText: user['username']),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Style2(outputText: 'ID: $userId'),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Last Message: $lastMessage',
                                      style:
                                          const TextStyle(color: Colors.black),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      );
                    }
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.center,
                      child: const Text('Loading...'),
                    );
                  });
            },
          );
        },
      ),
    );
  }
}
