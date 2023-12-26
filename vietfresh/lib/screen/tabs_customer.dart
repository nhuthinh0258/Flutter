import 'package:chat_app/provider/bottom_navigation_provider.dart';
import 'package:chat_app/screen/chat.dart';
import 'package:chat_app/screen/customer_detail.dart';
import 'package:chat_app/screen/home_page.dart';
import 'package:chat_app/screen/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});
  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  bool isHideKeyboard = false;
  int selectedPageIndex = 0;
  final List<Widget> pages = [
    const HomePage(),
    const Order(),
    const ChatScreen(),
    const CustomerDetail(),
  ];

  final List<String> pageTitles = [
    "Trang Chủ",
    "Đơn Hàng",
    "Hỗ Trợ",
    "Tài Khoản",
  ];

  void selectedPage(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardVisible = ref.watch(bottomNavigationProvider);
    return Scaffold(
        appBar: AppBar(
          title: Text(pageTitles[selectedPageIndex]),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.shopping_cart),
            ),
          ],
        ),
        body: pages[selectedPageIndex],
        bottomNavigationBar: selectedPageIndex == 2
            ? isKeyboardVisible
                ? BottomNavigationBar(
                    onTap: selectedPage,
                    currentIndex: selectedPageIndex,
                    items: const [
                      BottomNavigationBarItem(
                          icon: Icon(
                            Icons.home,
                            color: Colors.white,
                          ),
                          label: 'Trang chủ'),
                      BottomNavigationBarItem(
                          icon: Icon(
                            Icons.receipt,
                            color: Colors.white,
                          ),
                          label: 'Đơn hàng'),
                      BottomNavigationBarItem(
                          icon: Icon(
                            Icons.chat,
                            color: Colors.white,
                          ),
                          label: 'Hỗ trợ'),
                      BottomNavigationBarItem(
                          icon: Icon(
                            Icons.account_circle,
                            color: Colors.white,
                          ),
                          label: 'Tôi'),
                    ],
                    selectedItemColor: Colors.yellow,
                  )
                : null
            : BottomNavigationBar(
                onTap: selectedPage,
                currentIndex: selectedPageIndex,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home,
                        color: Colors.white,
                      ),
                      label: 'Trang chủ'),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.receipt,
                        color: Colors.white,
                      ),
                      label: 'Đơn hàng'),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.chat,
                        color: Colors.white,
                      ),
                      label: 'hỗ trợ'),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.account_circle,
                        color: Colors.white,
                      ),
                      label: 'Tôi'),
                ],
                selectedItemColor: Colors.yellow,
              ));
  }
}
