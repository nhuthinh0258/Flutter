import 'package:flutter/material.dart';
import 'package:shopping_app/screens/category_list.dart';
import 'package:shopping_app/screens/groceries.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int selectedPageIndex = 0;
  final List<Widget> pages = [
    const Groceries(),
    const CategoryList(),
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
              icon: Icon(Icons.production_quantity_limits), label: 'sản phẩm'),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Đơn hàng'),
        ],
        selectedItemColor: Colors.yellow,
      ),
    );
  }
}
