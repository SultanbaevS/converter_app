import 'package:circle_flags/circle_flags.dart';
import 'package:converter_app/src/features/converter/data/currency_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_text.dart';

class ConvertWIdget extends StatefulWidget {
  final List<Currency> allCurrencies;
  final ValueNotifier<String> currentCity;
  final ValueNotifier<bool> isUzbekistan;
  final void Function(ValueNotifier<String> currentCity) getConvert;
  final bool enabled;

  final TextEditingController? textEditingController1;
  final TextEditingController? textEditingController2;

  const ConvertWIdget({
    super.key,
    required this.allCurrencies,
    required this.currentCity,
    required this.isUzbekistan,
    required this.getConvert,
    required this.enabled,
    this.textEditingController1,
    this.textEditingController2,
  });

  @override
  State<ConvertWIdget> createState() => _ConvertWIdgetState();
}

class _ConvertWIdgetState extends State<ConvertWIdget> {
  String result = '0';

  void exchange(String v) {
    final current = double.tryParse(v) ?? 0;

    final a = widget.allCurrencies
        .where((e) => e.ccy == widget.currentCity.value)
        .first
        .rate;

    if (widget.isUzbekistan.value) {
      result =
          (current / (double.tryParse(a!) as double)).toStringAsPrecision(9);

      widget.textEditingController2?.text = result;
    } else {
      result = ((double.tryParse(a!) as double) * (double.tryParse(v) ?? 0))
          .toStringAsPrecision(9);
      widget.textEditingController2?.text = result;
    }

    if (widget.textEditingController1?.text.isEmpty ?? false) {
      widget.textEditingController2?.text = '0';
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.isUzbekistan,
      builder: (context, value, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: const Color(0xFF26278D),
                  radius: 25,
                  child: CircleFlag(
                    value
                        ? 'UZ'
                        : widget.currentCity.value == 'EUR'
                            ? 'european_union'
                            : widget.currentCity.value.substring(0, 2),
                  ),
                ),
                13.horizontalSpace,
                value
                    ? CustomText(
                        text: 'UZS',
                        color: const Color(0xFF26278D),
                        fontWeight: FontWeight.bold,
                      )
                    : DropdownButton(
                        underline: const SizedBox.shrink(),
                        value: widget.currentCity.value,
                        focusColor: Colors.transparent,
                        menuMaxHeight: 250,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        iconEnabledColor: const Color(0xFF26278D),
                        elevation: 4,
                        items: List.generate(
                          widget.allCurrencies.length,
                          (index) => DropdownMenuItem(
                            value: widget.allCurrencies[index].ccy,
                            child: CustomText(
                              text: widget.allCurrencies[index].ccy ?? '',
                              color: const Color(0xFF26278D),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          widget.currentCity.value = value!;
                          widget.getConvert(widget.currentCity);
                          widget.textEditingController1?.clear();
                          widget.textEditingController2?.clear();
                          setState(() {});
                        },
                      ),
              ],
            ),
            16.horizontalSpace,
            SizedBox(
              width: 130.w,
              height: 40.h,
              child: TextField(
                controller: widget.enabled
                    ? widget.textEditingController1
                    : widget.textEditingController2,
                onChanged: (value) {
                  exchange(value);
                },
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter(RegExp(r'[0-9\.]'), allow: true)
                ],
                style: const TextStyle(
                  color: Color(0xFF26278D),
                  fontWeight: FontWeight.bold,
                ),
                enabled: widget.enabled,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  filled: true,
                  hintText: widget.enabled ? '0' : result,
                  fillColor: const Color(0xFFD0C7C7),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  disabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
