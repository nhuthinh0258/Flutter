import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();

enum Category { food, travel, leisure, work }

final formatter = DateFormat('dd/MM/yyyy'); //Định dạng ngày tháng năm

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.leisure: Icons.movie,
  Category.travel: Icons
      .flight_takeoff, //Đoạn mã trên tạo một Map gọi là categoryIcons với các cặp key-value tương ứng. Key của mỗi cặp là một giá trị từ enum Category và value tương ứng là một icon từ thư viện Icons trong Flutter.
  Category.work: Icons.work,
};

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();

  final String id; //Mã định danh
  final String title;
  final double amount; //số tiền
  final DateTime date; //Ngày tháng
  final Category category;

  String get formattedDate {
    //định nghĩa một phương thức formattedDate trong một lớp hoặc đối tượng nào đó. Phương thức này trả về một chuỗi đại diện cho ngày được định dạng theo một định dạng cụ thể.
    return formatter.format(
        date); //Phương thức formattedDate sử dụng formatter.format(date) để định dạng giá trị date thành chuỗi ngày theo định dạng được chỉ định bởi formatter. Kết quả của phương thức là chuỗi đại diện cho ngày đã định dạng.
  }
}

//Phương thức get trong đoạn mã được sử dụng để định nghĩa một thuộc tính có tên totalExpenses, được tính toán dựa trên danh sách expenses.
class ExpenseBuck {
  ExpenseBuck({required this.category, required this.expenses});

  ExpenseBuck.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses.where((expense) {
          //Dấu : là danh sách khởi tạo
          return expense.category == category;
        }).toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {

    //Cách 1: sử dụng for
    double sum = 0;
    for (final expense in expenses) {
      sum = sum + expense.amount;
    }

    return sum;
  }
}
