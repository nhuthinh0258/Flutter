import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ListtileMain extends StatelessWidget {
  const ListtileMain(
      {super.key,
      required this.icon,
      required this.title,
      required this.ontap});
  final IconData icon;
  final String title;
  final void Function() ontap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
        color: Theme.of(context).colorScheme.onBackground,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 24,
            ),
      ),
      onTap: ontap,
    );
  }
}
