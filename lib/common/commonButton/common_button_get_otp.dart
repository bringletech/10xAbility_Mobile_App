import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class CommonFirstButtonGetOtp extends StatelessWidget {
  final String? imageUrl;
  final VoidCallback onPressed;
  final String text;
  final double height;
  final double width;
  final double fontSize;
  final String fontFamily;
  final FontWeight fontWeight;
  final Color color;
  final Color? contenerColor;
  final Color? borderColor;
  const CommonFirstButtonGetOtp({super.key, required this.onPressed, required this.text, this.imageUrl, required this.height,
    required this.width, required this.fontSize, required this.fontFamily, required this.fontWeight,
    required this.color, this.contenerColor, this.borderColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.only(left: 10,right: 10),
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: contenerColor,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: borderColor!,
            )
        ),
        child: Center(
          child: Row(
            //crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (imageUrl != null && imageUrl!.isNotEmpty) ...[
                SvgPicture.asset(imageUrl!, height: 24, width: 24),
                const SizedBox(width: 10),
              ],
              SizedBox(width: 10,),
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  fontFamily: fontFamily,
                  color: color,
                ),
              ),
            ],
          ),
        ),


      ),
    );
  }
}