import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meals/screens/tabs.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 131, 57, 0),
  ),
  textTheme: GoogleFonts.robotoTextTheme(),
);

void main() {
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        // Đăng ký các named routes và liên kết chúng với các màn hình tương ứng
        '/first': (context) {
          return const TabScreen(); //// Màn hình chính
        },
      },
      theme: theme,
      initialRoute:
          '/first', //// Màn hình chính sẽ được mở khi ứng dụng khởi đầu
    );
  }
}
