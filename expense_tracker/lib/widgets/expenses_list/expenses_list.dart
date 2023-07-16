import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });
  final void Function(Expense expense) onRemoveExpense;
  final List<Expense> expenses;

  Widget expen(context, index) {
    void dismissed(direction) {     //tạo hiệu ứng khi vuốt hoặc xóa các phần tử trong danh sách
      onRemoveExpense(
        expenses[index],
      );
    }

    return Dismissible(
      key: ValueKey(expenses[
              index] //tạo ra một key duy nhất dựa trên giá trị của phần tử trong danh sách expenses.ValueKey(expenses[index]) sử dụng giá trị của phần tử expenses[index] như là giá trị để tạo key. Điều này đảm bảo rằng mỗi phần tử trong danh sách có một key duy nhất dựa trên giá trị của nó.
          ),
      background: Container(
        color: Theme.of(context)
            .colorScheme
            .error
            .withOpacity(0.75), //Thiết lập màu nền khi xóa 1 card
        margin: EdgeInsets.symmetric(
          horizontal: Theme.of(context)
              .cardTheme
              .margin!
              .horizontal, //Tạo margin khi card bị xóa
        ),
      ),
      onDismissed: dismissed,
      child: ExpenseItem(
        expense: expenses[index],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {  
    return ListView.builder(      //xây dựng danh sách dựa trên một danh sách dữ liệu và builder function
      itemCount: expenses.length,
      itemBuilder: expen,
    );
  }
}
