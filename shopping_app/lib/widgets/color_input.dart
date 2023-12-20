import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerWidget extends StatefulWidget {
  const ColorPickerWidget({super.key});
  @override
  State<ColorPickerWidget> createState() {
    return _ColorPickerWidgetState();
  }
}

class _ColorPickerWidgetState extends State<ColorPickerWidget> {
  Color pickerColor = const Color(0xff443a49);

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ColorPicker(
          pickerColor: pickerColor,
          onColorChanged: changeColor,
          enableAlpha: false,
          labelTypes: const [],
          displayThumbColor: false,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Mã màu: ${pickerColor.value.toRadixString(16).toUpperCase()}',
            style: const TextStyle(fontWeight: FontWeight.bold,
            color: Colors.black),
          ),
        ),
      ],
    );
  }
}

