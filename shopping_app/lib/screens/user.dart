import 'package:flutter/material.dart';
import 'package:shopping_app/screens/tabs.dart';
import 'package:shopping_app/style.dart';

class User extends StatefulWidget {
  const User({super.key});
  @override
  State<User> createState() {
    return _UserState();
  }
}

class _UserState extends State<User> {
  void onMoveTab() {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
      return const TabsScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('data'),
      ),
      body: Center(
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Style(outputText: 'outputText'),
              onTap: onMoveTab,
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Style(outputText: 'outputText'),
              onTap: () {
                // Xử lý khi nhấn vào mục này
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Style(outputText: 'outputText'),
              onTap: () {
                // Xử lý khi nhấn vào mục này
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Style(outputText: 'outputText'),
              onTap: () {
                // Xử lý khi nhấn vào mục này
              },
            ),
          ],
        ),
      ),
    );
  }
}
