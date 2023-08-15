import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../model/currency_model.dart';
import 'convert_widget.dart';
import 'custom_text.dart';
import 'divider_and_change.dart';

class ConverterCard extends StatefulWidget {
  final List<Currency> allCurrencies;
  final ValueNotifier<String> currentCity;
  final ValueNotifier<bool> isUzbekistan;
  final void Function(ValueNotifier<String> currentCity) getConvert;

  const ConverterCard({
    super.key,
    required this.allCurrencies,
    required this.currentCity,
    required this.isUzbekistan,
    required this.getConvert,
  });

  @override
  State<ConverterCard> createState() => _ConverterCardState();
}

class _ConverterCardState extends State<ConverterCard> {
  late TextEditingController textEditingController1;
  late TextEditingController textEditingController2;

  @override
  void initState() {
    super.initState();
    textEditingController1 = TextEditingController()..addListener(() {});
    textEditingController2 = TextEditingController()..addListener(() {});
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController1.removeListener(() {});
    textEditingController2.removeListener(() {});
    textEditingController1.dispose();
    textEditingController2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320.w,
      height: 260.h,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        elevation: 4,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          child: ValueListenableBuilder(
            valueListenable: widget.isUzbekistan,
            builder: (context, value, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'Сумма',
                  ),
                  ConvertWIdget(
                    allCurrencies: widget.allCurrencies,
                    currentCity: widget.currentCity,
                    isUzbekistan: widget.isUzbekistan,
                    getConvert: widget.getConvert,
                    enabled: true,
                    textEditingController1: textEditingController1,
                    textEditingController2: textEditingController2,
                  ),
                  10.verticalSpace,
                  5.verticalSpace,
                  StackDivider(
                    isUzbekistan: widget.isUzbekistan,
                    currentCity: widget.currentCity,
                    getConvert: widget.getConvert,
                    textEditingController1: textEditingController1,
                    textEditingController2: textEditingController2,
                  ),
                  CustomText(
                    text: 'Конвертируемая сумма',
                  ),
                  ConvertWIdget(
                    allCurrencies: widget.allCurrencies,
                    currentCity: widget.currentCity,
                    isUzbekistan: ValueNotifier(!value),
                    getConvert: widget.getConvert,
                    enabled: false,
                    textEditingController2: textEditingController2,
                  ),
                  10.verticalSpace,
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
