
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../colors/colors.dart';

class CommonFirstButton extends StatelessWidget {
  final String? imageUrl;
  final VoidCallback onPressed;
  final String text;
  final double height;
  final double width;
  final double fontSize;
  final String fontFamily;
  final FontWeight fontWeight;
  final Color color;

  const CommonFirstButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.imageUrl,
    required this.height,
    required this.width,
    required this.fontSize,
    required this.fontFamily,
    required this.fontWeight,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: AppColors.redOrange,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (imageUrl != null && imageUrl!.isNotEmpty) ...[
                SvgPicture.asset(imageUrl!, height: 24, width: 24),
                const SizedBox(width: 10),
              ],
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

