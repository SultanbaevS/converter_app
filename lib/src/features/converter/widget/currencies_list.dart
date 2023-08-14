import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../data/currency_model.dart';
import 'currency_list_item.dart';

class CurrenciesList extends StatefulWidget {
  final List<Currency> allCurrencies;
  final List<Currency> latestAllCurrencies;
  final ValueNotifier<bool> isLoading;

  final Future<void> Function() onRefresh;

  const CurrenciesList({
    super.key,
    required this.allCurrencies,
    required this.latestAllCurrencies,
    required this.isLoading,
    required this.onRefresh,
  });

  @override
  State<CurrenciesList> createState() => _CurrenciesListState();
}

class _CurrenciesListState extends State<CurrenciesList> {
  late ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
  }

  String getDifference(Currency today, Currency lastDay) {
    final actualRate = double.tryParse(today.rate ?? '0') ?? 0;
    final lastDayRate = (double.tryParse(lastDay.rate ?? '0')) ?? 0;

    final diff = actualRate - lastDayRate;

    if (diff > 0) {
      return '+${diff.toStringAsFixed(2)}';
    } else if (diff < 0) {
      return diff.toStringAsFixed(2);
    } else {
      return '$diff';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 328.w,
      height: 250.h,
      child: Card(
        elevation: 4,
        color: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: ValueListenableBuilder(
          valueListenable: widget.isLoading,
          builder: (context, value, child) {
            return value
                ? const Center(
                    child: CircularProgressIndicator(color: Color(0xFF26278D)),
                  )
                : RefreshIndicator(
                    color: const Color(0xFF26278D),
                    displacement: 8,
                    onRefresh: widget.onRefresh,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 10.h),
                      child: ListView.separated(
                        itemCount: value ? 1 : widget.allCurrencies.length,
                        separatorBuilder: (context, index) => const Divider(),
                        itemBuilder: (context, index) {
                          if (value) {
                            return const SizedBox(
                              width: 10,
                              height: 10,
                            );
                          }

                          final Currency item = widget.allCurrencies[index];
                          final Currency lastDay =
                              widget.latestAllCurrencies[index];

                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: CurrencyListItem(
                              currency: item.ccyNmRu ?? '',
                              symbolCode: item.ccy ?? '',
                              change: getDifference(item, lastDay),
                              exchangeRate: item.rate ?? '',
                            ),
                          );
                        },
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
