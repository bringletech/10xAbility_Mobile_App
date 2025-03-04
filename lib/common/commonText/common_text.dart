
import 'package:flutter/material.dart';

import '../colors/colors.dart';



class CommonText extends StatelessWidget {
  final String text;
  final String fontFamily;
  final double fontSize;
  final FontWeight fontWeight;
  //final double height;
  const CommonText({super.key, required this.text, required this.fontSize, required this.fontFamily, required this.fontWeight, });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        text,
        style: TextStyle(fontSize:fontSize,
          fontFamily: fontFamily,fontWeight: fontWeight,
          color: AppColors.black,),
      ),
    );
  }
}
