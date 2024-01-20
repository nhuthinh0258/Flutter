import 'dart:convert';

import 'package:admin/screen/auth_admin.dart';
import 'package:admin/style.dart';
import 'package:admin/style2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'new_category.dart';

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() {
    return _UsersState();
  }
}

class _UsersState extends State<Users> {
  //Hàm xóa dữ liệu người dùng
  void onDeleteUser(
      String userId, String userImage, BuildContext context) async {
    //Xóa dữ liệu người dùng
    await firestore.collection('users').doc(userId).delete();
    //Xóa ảnh người dùng
    await firebaseStorage.refFromURL(userImage).delete();
    //Hiển thị thông báo xóa thành công
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Đã xóa dữ liệu người dùng'),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
            label: 'Đồng ý',
            onPressed: () {
              ScaffoldMessenger.of(context).clearSnackBars();
            }),
      ),
    );
  }

  void disableUser(
      String userId, bool isDisabledUser, BuildContext context) async {
    try {
      final url = Uri.http('0.0.0.0:3000',
          isDisabledUser ? '/enableUser' : '/disableUser');
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode({'userId': userId}),
      );
      isDisabledUser
          ? await firestore.collection('users').doc(userId).update({
              'isDisabled': false,
            })
          : await firestore.collection('users').doc(userId).update({
              'isDisabled': true,
            });

      if (!context.mounted) return;
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: isDisabledUser
              ? const Text('Đã mở khóa dữ liệu người dùng')
              : const Text('Đã khóa dữ liệu người dùng'),
          duration: const Duration(seconds: 2),
          action: SnackBarAction(
              label: 'Đồng ý',
              onPressed: () {
                ScaffoldMessenger.of(context).clearSnackBars();
              }),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Người Dùng'),
      ),
      body: StreamBuilder(
          stream: firestore.collection('users').snapshots(),
          builder: (ctx, usersSnapshot) {
            if (usersSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final usersData = usersSnapshot.data!.docs;
            return ListView.builder(
                itemCount: usersData.length,
                itemBuilder: (ctx, index) {
                  final users = usersData[index].data();
                  bool isDisabled = users['isDisabled'] ?? false;
                  return Dismissible(
                    background: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 8),
                      color:
                          Theme.of(context).colorScheme.error.withOpacity(0.5),
                    ),
                    key: Key(usersData[index].id),
                    onDismissed: (direction) {
                      if (users['role'] != 'admin') {
                        onDeleteUser(
                          usersData[index].id,
                          users['image'],
                          context,
                        );
                        usersData.removeAt(index);
                      } else {
                        setState(() {
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  const Text('Không thể xóa tài khoản admin'),
                              duration: const Duration(seconds: 2),
                              action: SnackBarAction(
                                  label: 'Đồng ý',
                                  onPressed: () {
                                    ScaffoldMessenger.of(context)
                                        .clearSnackBars();
                                  }),
                            ),
                          );
                        });
                      }
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 8),
                      color: Theme.of(context).primaryColorLight,
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Style(outputText: 'Email: ${users['email']}'),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Style2(outputText: 'Mã: ${usersData[index].id}'),
                            const SizedBox(
                              height: 5,
                            ),
                            Style2(
                                outputText:
                                    'Số điện thoại: ${users['user_phone'] ?? ''}'),
                          ],
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            disableUser(
                              usersData[index].id,
                              isDisabled,
                              context,
                            );
                          },
                          icon: Icon(isDisabled
                              ? Icons.visibility_off
                              : Icons.visibility),
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
