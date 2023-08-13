import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomText extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;
  final double fontSize;
  final Color color;

  CustomText({
    required this.text,
    this.fontWeight = FontWeight.w400,
    double? fontSize,
    Color? color,
    super.key,
  })  : fontSize = fontSize ?? 15.sp,
        color = color ?? const Color(0xFFA1A1A1);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
