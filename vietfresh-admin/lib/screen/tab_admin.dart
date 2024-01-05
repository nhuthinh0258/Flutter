import 'package:admin/screen/categories.dart';
import 'package:admin/screen/order.dart';
import 'package:admin/screen/origin.dart';
import 'package:admin/screen/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/bottom_navigation_provider.dart';

class TabsAdmin extends ConsumerStatefulWidget {
  const TabsAdmin({super.key});
  @override
  ConsumerState<TabsAdmin> createState() {
    return _TabsAdminState();
  }
}

class _TabsAdminState extends ConsumerState<TabsAdmin> {
  int selectedPageIndex = 0;
  final List<Widget> pages = [
    const Product(),
    const Categories(),
    const Order(),
    const Origin(),
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
        body: pages[selectedPageIndex],
        bottomNavigationBar: selectedPageIndex == 0 || selectedPageIndex == 2
            ? isKeyboardVisible
                ? BottomNavigationBar(
                    onTap: selectedPage,
                    currentIndex: selectedPageIndex,
                    items: const [
                      BottomNavigationBarItem(
                          icon: Icon(Icons.inventory), label: 'Sản phẩm'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.category), label: 'Loại sp'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.receipt), label: 'Hóa đơn'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.storage), label: 'Cập nhật'),
                    ],
                    selectedItemColor: Colors.yellow,
                  )
                : null
            : BottomNavigationBar(
                onTap: selectedPage,
                currentIndex: selectedPageIndex,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.inventory), label: 'Sản phẩm'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.category), label: 'Loại sp'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.receipt), label: 'Hóa đơn'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.storage), label: 'Cập nhật'),
                ],
                selectedItemColor: Colors.yellow,
              ));
  }
}
