import 'package:chat_app/provider/customer_provider.dart';
import 'package:chat_app/screen/auth.dart';
import 'package:chat_app/style.dart';
import 'package:chat_app/widgets/user_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomerDetail extends ConsumerWidget {
  const CustomerDetail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userEmail = ref.watch(userProvider).userEmail;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tài khoản'),
      ),
      body: SingleChildScrollView(
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
                    const UserImage(),
                    Style(
                      outputText: 'Xin chào: $userEmail',
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
                            Icons.account_circle,
                            color: Color.fromARGB(255, 77, 71, 71),
                          ),
                          title: const Style(outputText: 'Chi tiết tài khoản'),
                          onTap: () {
                            // Xử lý khi nhấn vào mục này
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          leading: const Icon(
                            Icons.sell,
                            color: Color.fromARGB(255, 77, 71, 71),
                          ),
                          title: const Style(outputText: 'Đăng ký bán hàng'),
                          onTap: () {
                            // Xử lý khi nhấn vào mục này
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          leading: const Icon(
                            Icons.settings,
                            color: Color.fromARGB(255, 77, 71, 71),
                          ),
                          title: const Style(outputText: 'Cài đặt'),
                          onTap: () {
                            // Xử lý khi nhấn vào mục này
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          leading: const Icon(
                            Icons.bar_chart,
                            color: Color.fromARGB(255, 77, 71, 71),
                          ),
                          title: const Style(outputText: 'Thống kê'),
                          onTap: () {
                            // Xử lý khi nhấn vào mục này
                          },
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
                          onTap: () {
                            // Xử lý khi nhấn vào mục này
                          },
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
                          onTap: () {
                            // Xử lý khi nhấn vào mục này
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      firebase.signOut();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        )),
                    child: const Style(outputText: 'Đăng xuất'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
