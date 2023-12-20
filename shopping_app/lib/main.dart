import 'package:flutter/material.dart';
import  'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/screens/groceries.dart';
import 'package:shopping_app/screens/tabs.dart';
import 'package:shopping_app/screens/user.dart';

void main() {
  runApp(const ProviderScope(child:MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Groceries',
      theme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 147, 229, 250),
          brightness: Brightness.dark,
          surface: const Color.fromARGB(255, 1, 94, 15),
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 240, 235, 235),
        primaryColorLight: const Color.fromARGB(255, 230, 228, 193),
        primaryColorDark: const Color.fromARGB(255, 161, 161, 147)
      ),
      home:const TabsScreen(),
    );
  }
}
