import 'package:flutter/material.dart';

class ReponsiveAdd3 extends StatelessWidget {
  const ReponsiveAdd3(
      {super.key,
      required this.clearData,
      required this.closeAdd,
      required this.expenseSubmitData});

  final void Function() expenseSubmitData;
  final void Function() clearData;
  final void Function() closeAdd;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
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
          onPressed: clearData,
          child: const Text('Clear'),
        ),
        // const SizedBox(
        //   width: 6,
        // ),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: const Color.fromARGB(157, 255, 5, 5),
          ),
          onPressed: closeAdd,
          child: const Text('Close'),
        ),
      ],
    );
  }
}
