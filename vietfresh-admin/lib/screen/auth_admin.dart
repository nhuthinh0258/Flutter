import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Biến firebasecó thể được sử dụng để gọi các phương thức liên quan đến xác thực người dùng, như đăng ký, đăng nhập, đăng xuất,
// kiểm tra trạng thái đăng nhập hiện tại
final firebase = FirebaseAuth.instance;
final firestore = FirebaseFirestore.instance;

class AuthAdmin extends StatefulWidget {
  const AuthAdmin({super.key});

  @override
  State<AuthAdmin> createState() {
    return _AuthAdminState();
  }
}

class _AuthAdminState extends State<AuthAdmin> {
  final formKey = GlobalKey<FormState>();
  var isAdmin = true;
  var enteredEmail = '';
  var enteredPassword = '';
  var isAuth = false;

  String? onEnteredEmail(String? value) {
    if (value == null || value.trim().isEmpty || !value.contains('@')) {
      return 'Email không hợp lệ';
    }
    return null;
  }

  String? onEnteredPassword(String? value) {
    if (value == null || value.trim().length < 6) {
      return 'Mật khẩu không hợp lệ';
    }
    return null;
  }

  //Hàm xử lý nút đăng ký, đăng nhập
  void onLoginButton() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      try {
        setState(() {
          isAuth = true;
        });
        if (isAdmin) {
          await firebase.signInWithEmailAndPassword(
              email: enteredEmail, password: enteredPassword);

        } else {
          final userCreate = await firebase.createUserWithEmailAndPassword(
            email: enteredEmail,
            password: enteredPassword,
          );
          //Dùng firestore để lưu trữ dữ liệu người dùng vào cơ sở dữ liệu
          await firestore.collection('users').doc(userCreate.user!.uid).set({
            'email': enteredEmail,
            'role': 'admin',
          });

        }
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.code)));
        setState(() {
          isAuth = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tài khoản',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 30,
                  bottom: 20,
                  left: 20,
                  right: 20,
                ),
                width: 300,
                child: Image.asset('assets/images/VietFresh.png'),
              ),
              Card(
                color: Theme.of(context).primaryColorLight,
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text('Tên đăng nhập'),
                            ),
                            validator: onEnteredEmail,
                            keyboardType: TextInputType.emailAddress,
                            //Tắt tự động điều chỉnh chính tả
                            autocorrect: false,
                            //Tắt tự động viết hoa chữ đầu tiên
                            textCapitalization: TextCapitalization.none,
                            onSaved: (value) {
                              enteredEmail = value!;
                            },
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text('Mật khẩu'),
                            ),
                            //nội dung nhập vào trong trường văn bản có được hiển thị dưới dạng ký tự che giấu
                            obscureText: true,
                            validator: onEnteredPassword,
                            onSaved: (value) {
                              enteredPassword = value!;
                            },
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          isAuth
                              ? const CircularProgressIndicator()
                              : ElevatedButton(
                                  onPressed: onLoginButton,
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                          255, 169, 215, 191)),
                                  child:
                                      Text((isAdmin) ? 'Đăng nhập' : 'Đăng ký'),
                                ),
                          // if (!isAuth)
                          //   TextButton(
                          //     onPressed: () {
                          //       setState(() {
                          //         isAdmin = !isAdmin;
                          //       });
                          //     },
                          //     child: Text(
                          //         isAdmin ? 'Đăng ký' : 'Đã có tài khoản?'),
                          //   ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
