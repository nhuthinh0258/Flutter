import 'package:flutter/material.dart';

import 'package:meals/widget/listtile_main.dart';

class DrawerMain extends StatelessWidget {
  const DrawerMain({super.key,required this.onSelectScreen});

  final void Function(String indentify) onSelectScreen;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      //hiển thị một drawer (ngăn kéo) trong Scaffold
      child: Column(
        children: [
          DrawerHeader(
            //hiển thị một phần đầu của drawer (ngăn kéo) trong Scaffold. Nó thường chứa thông tin người dùng hoặc logo của ứng dụng
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primaryContainer,
                Theme.of(context).colorScheme.primaryContainer.withOpacity(0.8)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
            child: Row(
              children: [
                Icon(
                  Icons.food_bank,
                  size: 48,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 18),
                Text(
                  'Restaurant',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 36,
                      ),
                ),
              ],
            ),
          ),
          ListtileMain(
            icon: Icons.restaurant,
            title: 'Meals',
            ontap: () {
              onSelectScreen('meals');
            },
          ),
          ListtileMain(
            icon: Icons.filter_list,
            title: 'Filters',
            ontap: () {
              onSelectScreen('filters');
            },
          ),
        ],
      ),
    );
  }
}
