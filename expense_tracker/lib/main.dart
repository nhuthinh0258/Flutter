import 'package:expense_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 229, 204,
      232), //tạo một ColorScheme dựa trên một màu gốc (seed color). Nó sẽ sinh ra các màu khác cho các thành phần khác nhau của giao diện người dùng dựa trên màu gốc đó.
);
var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

void main() {
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kDarkColorScheme,
        cardTheme: const CardTheme().copyWith(
          //màu card
          color: kDarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          //màu elevatedbutton
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.primaryContainer,
            foregroundColor: kDarkColorScheme.onPrimaryContainer,
          ),
        ),
      ),
      theme: ThemeData().copyWith(
        //copyWith cho phép duy trì các giá trị hiện có của các thuộc tính khác trong ThemeData.
        useMaterial3: true,
        // scaffoldBackgroundColor:const Color.fromARGB(255, 229, 204, 232), //nền chính của ứng dụng
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          //màu appbar
          backgroundColor: kColorScheme.onPrimaryContainer, //màu nền
          foregroundColor: Colors.blue.shade100, //màu chữ
        ),
        cardTheme: const CardTheme().copyWith(
          //màu card
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          //màu elevatedbutton
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
            // foregroundColor: Colors.lightBlue,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              //Màu text
              titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: kColorScheme.onSecondaryContainer,
              ),
              bodyMedium: TextStyle(
                color: kColorScheme.onSecondaryContainer,
              )
            ),
        
      ),
      home: const Expenses(),
    ),
  );
}
