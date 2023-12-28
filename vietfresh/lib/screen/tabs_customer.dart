import 'package:chat_app/provider/bottom_navigation_provider.dart';
import 'package:chat_app/screen/auth.dart';
import 'package:chat_app/screen/cart.dart';
import 'package:chat_app/screen/chat.dart';
import 'package:chat_app/screen/customer_detail.dart';
import 'package:chat_app/screen/home_page.dart';
import 'package:chat_app/screen/order.dart';
import 'package:chat_app/widgets/cart_icon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebase = FirebaseAuth.instance;

class TabsUser extends ConsumerStatefulWidget {
  const TabsUser({super.key});
  @override
  ConsumerState<TabsUser> createState() {
    return _TabsUserState();
  }
}

class _TabsUserState extends ConsumerState<TabsUser> {
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
    final user = firebase.currentUser!;
    return Scaffold(
        appBar: AppBar(
          title: Text(pageTitles[selectedPageIndex]),
          actions: [
            StreamBuilder(
                stream: firestore.collection('cart').doc(user.uid).snapshots(),
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active &&
                      snapshot.hasData) {
                    final cartData = snapshot.data!.data();
                    List<dynamic> cartItems = cartData!['products'] ?? [];
                    int itemCount = cartItems.length;
                    return Container(
                      margin: const EdgeInsets.only(right: 20),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (ctx) {
                            return const Cart();
                          }));
                        },
                        child: CartIconWithBadge(
                          itemCount: itemCount,
                        ),
                      ),
                    );
                  }
                  return IconButton(
                    icon:const Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (ctx) {
                        return const Cart();
                      }));
                    },
                  );
                }),
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
                            Icons.person,
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
                        Icons.person,
                        color: Colors.white,
                      ),
                      label: 'Tôi'),
                ],
                selectedItemColor: Colors.yellow,
              ));
  }
}
