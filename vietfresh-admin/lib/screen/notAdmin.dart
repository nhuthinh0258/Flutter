import 'package:admin/screen/auth_admin.dart';
import 'package:flutter/material.dart';

class NotAdmin extends StatelessWidget {
  const NotAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                firebase.signOut();
              },
              icon: const Icon(Icons.exit_to_app),
            ),
          ],
        ),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Bạn không có quyền truy cập, vui lòng thử lại sau'),
          ),
        ));
  }
}
