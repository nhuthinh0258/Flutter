import 'package:flutter/material.dart';
import 'package:first_app/styled_text.dart';
import 'dart:math';


final random = Random();

class DiceRoll extends StatefulWidget {
  const DiceRoll({super.key});

  @override
  State<DiceRoll> createState() {
    return _DiceRollState();
  }
}

class _DiceRollState extends State<DiceRoll> {
  var currentDiceRoll = 2;

  void rollDice() {
    setState(() {
        currentDiceRoll = random.nextInt(6)+1;
        // activiDiceImage = 'assets/images/dice-2.png';
        // activiDiceImage = 'assets/images/dice-2.png';
        // activiDiceImage = 'assets/images/dice-3.png';
        // activiDiceImage = 'assets/images/dice-4.png';
        // activiDiceImage = 'assets/images/dice-5.png';
        // activiDiceImage = 'assets/images/dice-6.png';
    });
  }

  @override
  Widget build(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/dice-$currentDiceRoll.png',
          width: 150,
        ),
        const SizedBox(
          height: 40,
        ),
        TextButton(
          onPressed: rollDice,
          // style: TextButton.styleFrom(
          //   padding: const EdgeInsets.only(
          //     top: 40,
          //   ),
          // ),
          child: const StyledText('Tung xúc xắc'),
        )
      ],
    );
  }
}
