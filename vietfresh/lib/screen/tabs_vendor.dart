import 'package:chat_app/screen/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabsVendor extends ConsumerStatefulWidget {
  const TabsVendor({super.key});
  @override
  ConsumerState<TabsVendor> createState() {
    return _TabsVendorState();
  }
}

class _TabsVendorState extends ConsumerState<TabsVendor> {
  int selectedPageIndex = 0;
  final List<Widget> pages = [
    const Product(),
  ];

  void selectedPage(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[selectedPageIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: selectedPage,
          currentIndex: selectedPageIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.production_quantity_limits),
                label: 'Sản phẩm'),
          ],
          selectedItemColor: Colors.yellow,
        ));
  }
}
