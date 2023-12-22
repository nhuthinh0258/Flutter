import 'package:chat_app/screen/auth.dart';
import 'package:chat_app/screen/tabs_customer.dart';
import 'package:chat_app/style.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: firebase.authStateChanges(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasData) {
            return const TabsScreen();
          }
          return SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 40,
                      horizontal: 30,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CircleAvatar(
                          radius: 50,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (ctx) {
                              return const AuthScreen();
                            }));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor),
                          child: const Style(
                            outputText: 'Đăng nhập/ Đăng ký',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: const Color.fromARGB(255, 232, 223, 223),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: ListTile(
                              leading: const Icon(
                                Icons.settings,
                                color: Color.fromARGB(255, 77, 71, 71),
                              ),
                              title: const Style(outputText: 'Cài đặt'),
                              onTap: () {},
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: ListTile(
                              leading: const Icon(
                                Icons.report,
                                color: Color.fromARGB(255, 77, 71, 71),
                              ),
                              title: const Style(outputText: 'Báo cáo'),
                              onTap: () {},
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: ListTile(
                              leading: const Icon(
                                Icons.help,
                                color: Color.fromARGB(255, 77, 71, 71),
                              ),
                              title: const Style(outputText: 'Trợ giúp'),
                              onTap: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
