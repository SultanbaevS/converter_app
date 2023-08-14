import 'package:circle_flags/circle_flags.dart';
import 'package:converter_app/src/features/converter/widget/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CurrencyListItem extends StatefulWidget {
  final String currency;
  final String symbolCode;
  final String change;
  final String exchangeRate;

  const CurrencyListItem({
    super.key,
    required this.currency,
    required this.symbolCode,
    required this.change,
    required this.exchangeRate,
  });

  @override
  State<CurrencyListItem> createState() => _CurrencyListItemState();
}

class _CurrencyListItemState extends State<CurrencyListItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 85,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: '1 ${widget.currency}',
            fontWeight: FontWeight.bold,
          ),
          5.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: const Color(0xFFA1A1A1),
                radius: 25,
                child: CircleFlag((widget.symbolCode == 'EUR')
                    ? 'european_union'
                    : widget.symbolCode.substring(0, 2)),
              ),
              CustomText(
                text: widget.symbolCode,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CustomText(
                        text: widget.change,
                        color: (double.tryParse(widget.change ?? '0') ?? 0) > 0
                            ? CupertinoColors.activeGreen
                            : ((double.tryParse(widget.change) ?? 0) < 0)
                                ? Colors.red
                                : Colors.orange,
                      ),
                      Icon(
                        ((double.tryParse(widget.change) ?? 0) > 0)
                            ? Icons.trending_up
                            : ((double.tryParse(widget.change) ?? 0) < 0)
                                ? Icons.trending_down
                                : Icons.trending_neutral,
                        color: ((double.tryParse(widget.change) ?? 0) > 0)
                            ? CupertinoColors.activeGreen
                            : ((double.tryParse(widget.change) ?? 0) < 0)
                                ? Colors.red
                                : Colors.orange,
                      ),
                    ],
                  ),
                  CustomText(
                    text: widget.exchangeRate,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
