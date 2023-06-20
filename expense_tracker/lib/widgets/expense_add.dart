import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/widgets/reponsive/reponsive_add_one.dart';
import 'package:expense_tracker/widgets/reponsive/reponsive_add_three.dart';
import 'package:expense_tracker/widgets/reponsive/reponsive_add_two.dart';
import 'package:flutter/material.dart';

class ExpenseAdd extends StatefulWidget {
  const ExpenseAdd({super.key, required this.onAddExpense});
  final void Function(Expense expense) onAddExpense;

  @override
  State<StatefulWidget> createState() {
    return _ExpenseAdd();
  }
}

class _ExpenseAdd extends State<ExpenseAdd> {
  // Cách 1: xử lý và lưu trữ đầu vào của người dùng
  // var enteredTitle = '';

  // void saveTitleInput(String inputValue) {
  //   enteredTitle = inputValue;           //Khi phương thức saveTitleInput được gọi và truyền một giá trị inputValue, giá trị
  // }                                      //này sẽ được gán vào biến enteredTitle. Điều này cho phép bạn lưu giữ giá trị nhập vào từ người dùng và sử dụng sau này trong quá trình xử lý dữ liệu hoặc hiển thị trên giao diện người dùng.

  //Cách 2:
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime?
      selectedDate; //khai báo một biến selectedDate có kiểu dữ liệu là DateTime?,Khi khai báo biến selectedDate với kiểu dữ liệu DateTime?, đó có nghĩa là biến đó có thể chứa một giá trị của kiểu DateTime hoặc có thể là giá trị null
  Category selectedCategory = Category.food;
  Category defaultCategory =
      Category.food; // Giá trị mặc định cho DropdownButton
  DateTime?
      defaultDate; // Giá trị mặc định cho ngày được chọn (ban đầu là null)

  @override
  void dispose() {
    titleController.dispose(); //Giải phóng tài nguyên của TextEditingController
    amountController.dispose();
    super.dispose();
  }

  //hiển thị một hộp thoại chọn ngày cho người dùng
  void presentDayPicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 3, now.month, now.day);
    final lastDate = DateTime(now.year + 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      //Khi sử dụng await, chương trình sẽ đợi cho đến khi hộp thoại showDatePicker được đóng lại trước khi tiếp tục thực thi các dòng lệnh tiếp theo.
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    setState(() {
      selectedDate =
          pickedDate; //Sử dụng setState để cập nhật giá trị của selectedDate thành pickedDate. Việc này đảm bảo giao diện người dùng được cập nhật và hiển thị ngày mới được chọn.
    });
  }

  //Đóng lớp phủ
  void closeAdd() {
    Navigator.pop(
        context); // được sử dụng để đóng một màn hình hiện tại và quay trở lại màn hình trước đó.
  }

  // phương thức dropdownButton nhận một giá trị từ dropdown và cập nhật selectedCategory trong setState để kích hoạt việc cập nhật giao diện.
  void dropdownButton(value) {
    if (value == null) {
      //Phương thức này kiểm tra xem giá trị value có null hay không. Nếu value là null, phương thức sẽ thoát và không có hành động nào được thực hiện.
      return;
    }
    setState(() {
      selectedCategory =
          value; //Nếu value không null, phương thức sẽ gọi setState để cập nhật giá trị selectedCategory thành value
    });
  }

  //Nút submit
  void expenseSubmitData() {
    final enteredAmount = double.tryParse(amountController
        .text); //tryParse('hello') => null, tryParse('3.14')= 3.14
    final amountIsInvalid = enteredAmount == null ||
        enteredAmount <= 10000; //Số tiền nhập vào rỗng hoặc bé hơn 10k
    if (titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        selectedDate == null) {
      //Nếu dòng title trống hoặc tiền nhập vào rỗng hoặc bé hơn 10k hoặc ngày tháng rỗng
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text('Invalid Input'),
            content: const Text(
                'Hãy chắc chắn rằng bạn đã nhập đủ(đúng) dữ liệu (title,amount,date and category)'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Okay'),
              ),
            ],
          );
        },
      );
      return; //lệnh return; để dừng thực hiện hàm expenseSubmitData trong trường hợp dữ liệu không hợp lệ, để ngăn việc thêm chi tiêu vào danh sách.
    }
    widget.onAddExpense(
      Expense(
          title: titleController.text,
          amount: enteredAmount,
          date: selectedDate!,
          category: selectedCategory),
    );
    Navigator.pop(context);
  }

  //Nút clear
  void clearData() {
    titleController.clear(); //// Xóa giá trị trong TextField
    amountController.clear();
    setState(() {
      selectedCategory = defaultCategory;
      selectedDate = defaultDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context)
        .viewInsets
        .bottom; //biến keyboardSpace sẽ chứa giá trị chiều cao của không gian bàn phím hiển thị phía dưới
    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;
      return SizedBox(
        height: double
            .infinity, // yêu cầu widget đó có chiều cao bằng với kích thước tối đa có thể trong không gian mà widget đó được đặt.
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
            child: Column(
              children: [
                if (width >= 600)
                  ReponsiveAdd1(
                    amountController: amountController,
                    titleController: titleController,
                  )
                else
                  TextField(
                    controller: titleController, //Cách 1:saveTitleInput
                    maxLength: 50,
                    decoration: const InputDecoration(
                      label: Text('Title'),
                    ),
                  ),
                if (width >= 600)
                  ReponsiveAdd2(
                    selectedCategory: selectedCategory,
                    selectedDate: selectedDate,
                    dropdownButton: dropdownButton,
                    presentDayPicker: presentDayPicker,
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: amountController,
                          keyboardType: TextInputType
                              .number, //Dữ liệu chỉ nhập số trên máy
                          decoration: const InputDecoration(
                            prefixText: 'VND ', //Ký hiệu VND
                            label: Text('Amount'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              selectedDate == null
                                  ? 'Not Selected Date' //Nếu selectedDate là null, tức là ngày chưa được chọn, thì Text sẽ hiển thị chuỗi "Not Selected Date".
                                  : formatter.format(
                                      selectedDate!), //Nếu selectedDate không phải null, tức là đã có ngày được chọn, thì Text sẽ hiển thị giá trị của ngày đã chọn sau khi được định dạng bằng formatter.format(selectedDate!). selectedDate! sử dụng dấu thanh chắn (!) để gỡ bỏ cảnh báo về khả năng selectedDate có thể là null (null safety).
                            ),
                            IconButton(
                              onPressed: presentDayPicker,
                              icon: const Icon(Icons.calendar_month),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 16,
                ),
                if (width >= 600)
                  ReponsiveAdd3(
                    clearData: clearData,
                    closeAdd: closeAdd,
                    expenseSubmitData: expenseSubmitData,
                  )
                else
                  Row(
                    children: [
                      DropdownButton(
                        value: selectedCategory,
                        items: Category.values.map((item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(item.name.toUpperCase()),
                          );
                        }).toList(),
                        onChanged: dropdownButton,
                      ),
                      const Spacer(),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            //Style lại elevatedButton
                            // backgroundColor: const Color.fromARGB(168, 18, 65, 219),
                            shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                        onPressed: expenseSubmitData,
                        child: const Text('Submit'),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            //Style lại elevatedButton
                            // backgroundColor: const Color.fromARGB(168, 206, 219, 18),
                            shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                        onPressed: () {
                          titleController
                              .clear(); //// Xóa giá trị trong TextField
                          amountController.clear();
                          setState(() {
                            selectedCategory = defaultCategory;
                            selectedDate = defaultDate;
                          });
                        },
                        child: const Text('Clear'),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: const Color.fromARGB(157, 255, 5, 5),
                        ),
                        onPressed: closeAdd,
                        child: const Text('Close'),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
