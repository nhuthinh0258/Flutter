import 'package:admin/screen/categories.dart';
import 'package:admin/screen/origin.dart';
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
    const Categories(),
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
        bottomNavigationBar: selectedPageIndex == 1
            ? isKeyboardVisible
                ? BottomNavigationBar(
                    onTap: selectedPage,
                    currentIndex: selectedPageIndex,
                    items: const [
                      BottomNavigationBarItem(
                          icon: Icon(Icons.chat), label: 'hỗ trợ'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.account_circle), label: 'Tôi'),
                    ],
                    selectedItemColor: Colors.yellow,
                  )
                : null
            : BottomNavigationBar(
                onTap: selectedPage,
                currentIndex: selectedPageIndex,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.chat), label: 'hỗ trợ'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.account_circle), label: 'Tôi'),
                ],
                selectedItemColor: Colors.yellow,
              ));
  }
}
