import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StackDivider extends StatefulWidget {
  final ValueNotifier<bool> isUzbekistan;
  final ValueNotifier<String> currentCity;
  final void Function(ValueNotifier<String> currentCity) getConvert;

  final TextEditingController textEditingController1;
  final TextEditingController textEditingController2;

  const StackDivider({
    super.key,
    required this.isUzbekistan,
    required this.currentCity,
    required this.getConvert,
    required this.textEditingController1,
    required this.textEditingController2,
  });

  @override
  State<StackDivider> createState() => _StackDividerState();
}

class _StackDividerState extends State<StackDivider> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const Divider(
          color: Color(0xFFE7E7EE),
          thickness: 2,
        ),
        // GestureDetector(
        //   onTap: () {
        //     isUzbekistan.value = !isUzbekistan.value;
        //     getConvert(currentCity);
        //   },
        //   child: SizedBox(
        //     width: 44,
        //     height: 44,
        //     child: DecoratedBox(
        //       decoration: const BoxDecoration(
        //         shape: BoxShape.circle,
        //         color: Color(0xFF26278D),
        //       ),
        //       child: Padding(
        //         padding: EdgeInsets.all(8.0.h),
        //         child: const Image(
        //           image: AssetImage('assets/img/reverse.png'),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        SizedBox(
          width: 44,
          height: 44,
          child: IconButton(
            style: IconButton.styleFrom(
              backgroundColor: const Color(0xFF26278D),
            ),
            padding: EdgeInsets.zero,
            onPressed: () {
              widget.isUzbekistan.value = !widget.isUzbekistan.value;
              widget.getConvert(widget.currentCity);
              widget.textEditingController1.clear();
              widget.textEditingController2.clear();
              setState(() {});
            },
            icon: Padding(
              padding: EdgeInsets.all(8.0.h),
              child: const Image(
                image: AssetImage('assets/img/reverse.png'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
