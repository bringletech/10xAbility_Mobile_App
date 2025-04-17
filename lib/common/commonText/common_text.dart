
import 'package:flutter/material.dart';
import '../colors/colors.dart';





class CommonText extends StatelessWidget {
  final String text;
  final String fontFamily;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign? textAlign;
  //final double height;
  const CommonText({super.key, required this.text, required this.fontSize, required this.fontFamily, required this.fontWeight, this.textAlign, });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        text,
        textAlign: textAlign,
        style: TextStyle(fontSize:fontSize,
          fontFamily: fontFamily,fontWeight: fontWeight,
          color: AppColors.black,),
      ),
    );
  }
}
