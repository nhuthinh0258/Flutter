import 'package:expense_tracker/model/expense.dart';

import 'package:flutter/material.dart';

class ReponsiveAdd2 extends StatelessWidget{
  ReponsiveAdd2 ({super.key,required this.selectedCategory,required this.selectedDate,required this.dropdownButton, required this.presentDayPicker});

DateTime? selectedDate;
Category selectedCategory;
final void Function(Category?) dropdownButton;
final void Function() presentDayPicker;

  @override
  Widget build(BuildContext context) {
    return Row(
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
                      const SizedBox(width: 24),
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
                  );
  }
}