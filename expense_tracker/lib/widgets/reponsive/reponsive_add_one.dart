import 'package:flutter/material.dart';

class ReponsiveAdd1 extends StatelessWidget {
  const ReponsiveAdd1(
      {super.key,
      required this.amountController,
      required this.titleController});

  final TextEditingController titleController;
  final TextEditingController amountController;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: TextField(
            controller: titleController, //Cách 1:saveTitleInput
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
        ),
        const SizedBox(
          width: 24,
        ),
        Expanded(
          child: TextField(
            controller: amountController,
            keyboardType: TextInputType.number, //Dữ liệu chỉ nhập số trên máy
            decoration: const InputDecoration(
              prefixText: 'VND ', //Ký hiệu VND
              label: Text('Amount'),
            ),
          ),
        ),
      ],
    );
  }
}
