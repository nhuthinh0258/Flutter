import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StyledText extends StatelessWidget {
  const StyledText(this.outputText,this.colorText,this.font,this.fontWeight,{super.key});

  final String outputText;
  final Color colorText;
  final double font;
  final FontWeight fontWeight;

  @override
  Widget build(context) {
    return Text(
      outputText,
      style: GoogleFonts.lato(
        fontSize: font,
        color: colorText,
        fontWeight: fontWeight,
      ),
    );
  }
}


