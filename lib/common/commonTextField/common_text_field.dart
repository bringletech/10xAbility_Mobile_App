import 'package:flutter/material.dart';

import '../colors/colors.dart';

class CommonTextField extends StatelessWidget {
  final double height;
  final double width;
  final String hintText;
  final String text;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController controller;
  final TextInputType inputType;
  final bool readOnly;
  final Function()? onTap;  // Add an optional onTap parameter

  const CommonTextField({
    super.key,
    required this.hintText,
    required this.text,
    required this.controller,
    required this.inputType,
    this.prefixIcon,
    this.suffixIcon,
    required this.readOnly,
    this.onTap, required this.height, required this.width,  // Add onTap to constructor
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),
          ),
          SizedBox(height: 3),
          Container(
            //margin: const EdgeInsets.symmetric(horizontal: 10),
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.redOrange
              )
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Material(
              color: Colors.transparent,
              child: TextField(
                onTap: onTap,
                readOnly: readOnly,
                textAlignVertical: TextAlignVertical.center,
                keyboardType: inputType,
                controller: controller,
                decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  hintText: hintText,
                  prefixIcon: prefixIcon,
                  suffixIcon: suffixIcon,
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  hintStyle: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 11,
                    color: AppColors.gray,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
