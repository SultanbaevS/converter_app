import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopText extends StatelessWidget {
  const TopText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Конвертер валют',
          style: TextStyle(
            color: const Color(0xFF1F2261),
            fontSize: 25.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        10.verticalSpace,
        Text(
          'Проверяйте курсы валют в реальном времени.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color(0xFF808080),
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
