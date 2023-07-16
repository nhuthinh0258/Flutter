import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expense_add.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> registeredExpenses = [
    //Expense trong model
    Expense(
      title: 'Flutter course',
      amount: 18000,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinemax',
      amount: 22050000,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  //Show lớp phủ (Overlay)
  void openAddExpenseOverlay() {
    showModalBottomSheet(
        useSafeArea: true,    // tính toán và sử dụng không gian an toàn để đảm bảo rằng nội dung trong widget không bị che phủ bởi camera, etc ...
        isScrollControlled: true, //Làm lớp phủ(Overlay) được full màn hình
        context: context,
        builder: (ctx) {
          return ExpenseAdd(
            onAddExpense: addExpense,
          );
        });
  }

  //Model, Hàm addExpense được sử dụng để thêm một đối tượng expense vào danh sách registeredExpenses
  void addExpense(Expense expense) {
    setState(() {
      registeredExpenses.add(expense);
    });
  }

  //Hàm để xóa một đối tượng expense khỏi danh sách registeredExpenses
  void removeExpense(Expense expense) {
    final expenseIndex = registeredExpenses.indexOf(
        expense); //xác định chỉ số của expense trong danh sách bằng cách sử dụng indexOf
    setState(() {
      registeredExpenses.remove(expense); //Xóa expense
    });

    //Hàm để khôi phục chi phí đã bị xóa
    void undoExpense() {
      setState(() {
        registeredExpenses.insert(expenseIndex,
            expense); //chèn lại chi phí vào vị trí ban đầu của nó trong danh sách registeredExpenses bằng cách sử dụng insert.
      });
    }

    ScaffoldMessenger.of(context).clearSnackBars(); //xóa tất cả các snack bar đang hiển thị trong Scaffold hiện tại.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
        content: const Text('Đã xóa chi phí'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: undoExpense,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    

    Widget mainContent = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/cactus.png',
            width: 100,
            height: 100,
            color: Theme.of(context)
                .textTheme
                .bodyMedium!
                .color!
                .withOpacity(0.25),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Hiện không có chi phí nào, hãy tạo chi phí!',
            style: TextStyle(
              color: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .color!
                  .withOpacity(0.25),
            ),
          )
        ],
      ),
    );
    //nếu danh sách không rỗng, sẽ hiện thị list các chi phí, nếu rỗng hiển thị ảnh vào thông báo
    if (registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: registeredExpenses,
        onRemoveExpense: removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Flutter'),
        actions: [
          IconButton(
            onPressed: openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: width < 600
          ? Column(
              //Reponsives
              children: [
                Chart(
                  expenses: registeredExpenses,
                ),
                Expanded(
                  child: mainContent,
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Chart(expenses: registeredExpenses),
                ),
                Expanded(
                  child: mainContent,
                ),
              ],
            ),
    );
  }
}
