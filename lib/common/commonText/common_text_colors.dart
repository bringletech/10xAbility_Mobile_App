
import 'package:flutter/material.dart';

class CommonTextColors extends StatelessWidget {
  final Color color;
  final String text;
  final String fontFamily;
  final double fontSize;
  final FontWeight fontWeight;
  final TextDecoration? textDecoration;
  final Color? decorationColor;
  //final double height;
  const CommonTextColors({super.key, required this.text, required this.fontSize,
    required this.fontFamily, required this.fontWeight, required this.color,
    this.textDecoration, this.decorationColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        text,
        style: TextStyle(fontSize:fontSize,
          fontFamily: fontFamily,fontWeight: fontWeight,color: color,
            decoration: textDecoration,decorationColor: decorationColor),
      ),
    );
  }
}
