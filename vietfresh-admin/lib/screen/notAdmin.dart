
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final firebase = FirebaseAuth.instance;
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
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/cactus.png',
                      width: 100,
                      height: 100,
                      color:
                          Theme.of(context).primaryColorDark.withOpacity(0.75)),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Bạn không có quyền truy cập, vui lòng thử lại sau',
                    style: TextStyle(
                        color: Theme.of(context)
                            .primaryColorDark
                            .withOpacity(0.75)),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
