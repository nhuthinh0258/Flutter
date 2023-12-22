import 'package:admin/screen/auth_admin.dart';
import 'package:admin/screen/categories.dart';
import 'package:admin/screen/notAdmin.dart';
import 'package:admin/screen/tab_admin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (userSnapshot.hasData) {
              return FutureBuilder(
                  future: firestore
                      .collection('users')
                      .doc(userSnapshot.data!.uid)
                      .get(),
                  builder: (ctx, adminSnapshot) {
                    if (adminSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (adminSnapshot.hasData && adminSnapshot.data!.exists) {
                      final userData = adminSnapshot.data!.data();
                      final userRole = userData!['role'];
                      if (userRole == 'admin') {
                        return const TabsAdmin();
                      }
                    }
                    return const NotAdmin();
                  });
            }
            return const AuthAdmin();
          }),
    );
  }
}
