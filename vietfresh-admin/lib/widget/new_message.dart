import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../screen/auth_admin.dart';

class NewMessage extends ConsumerStatefulWidget {
  const NewMessage({super.key, required this.userId});
  final String userId;
  @override
  ConsumerState<NewMessage> createState() {
    return _NewMessageState();
  }
}

class _NewMessageState extends ConsumerState<NewMessage> {
  //Đối tượng messageController được sử dụng để kiểm soát nội dung của một TextField
  var messageController = TextEditingController();
  late FocusNode myFocusNode;

  // @override
  // void initState() {
  //   super.initState();
  //   myFocusNode = FocusNode();

  //   // Thêm listener
  //   myFocusNode.addListener(onFocusChange);
  // }

  // void onFocusChange() {
  //   if (myFocusNode.hasFocus) {
  //     ref.read(bottomNavigationProvider.notifier).hide();
  //   } else {
  //     ref.read(bottomNavigationProvider.notifier).show();
  //   }
  // }

  //giải phóng tài nguyên
  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  //Hàm xử lý gửi tin nhắn
  void submitMessage() async {
    // Lấy dữ liệu người dùng
    final user = firebase.currentUser!;
    // Lấy nội dung hiện tại từ TextField thông qua messageController.text
    final enteredMessage = messageController.text.trim();

    // Kiểm tra xem nội dung tin nhắn sau khi loại bỏ khoảng trắng ở đầu và cuối có phải là rỗng không
    if (enteredMessage.isEmpty) {
      // Nếu rỗng, kết thúc không làm gì cả
      return;
    }

    // Lấy dữ liệu tin nhắn từ Firestore
    final chatRef = firestore.collection('chat').doc(widget.userId);
    final chatSnapshot = await chatRef.get();

    // Kiểm tra xem đã có dữ liệu tin nhắn chưa
    if (chatSnapshot.exists) {
      // Nếu có, cập nhật tin nhắn
      final chats = List.from(chatSnapshot.data()!['chats'] ?? []);

      // Tạo một Map chứa thông tin tin nhắn và người gửi
      final messageInfo = {
        'message': enteredMessage,
        'senderId': user.uid,
        'sort_time':Timestamp.now()
      };

      chats.add(messageInfo);

      // Cập nhật dữ liệu tin nhắn trong Firestore
      await chatRef.update({
        'chats': chats,
        'lastMessage': enteredMessage,
        'lastMessageTime': Timestamp.now(),
      });
    }
    // Xóa nội dung của TextField sau khi gửi, chuẩn bị cho việc nhập tin nhắn tiếp theo.
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 1),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: messageController,
              // focusNode: myFocusNode,
              style: const TextStyle(color: Colors.black, fontSize: 14),
              //Mỗi câu mới sẽ bắt đầu bằng chữ viết hoa
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                label: const Text('Gửi tin nhắn'),
              ),
              onSubmitted: (value) {
                submitMessage();
              },
            ),
          ),
          IconButton(
              onPressed: submitMessage,
              icon: Icon(
                Icons.send,
                color: Theme.of(context).colorScheme.surface,
              ))
        ],
      ),
    );
  }
}
