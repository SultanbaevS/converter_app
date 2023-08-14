import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'converter_card.dart';
import 'top_text_widget.dart';
import 'currencies_list.dart';
import 'custom_text.dart';
import '../data/currency_model.dart';
import '../../../common/services/api_service.dart';
import '../data/repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ICurrencyRepository repository;
  List<Currency> allCurrencies = [];
  List<Currency> latestAllCurrencies = [];

  ValueNotifier<String> currentCity = ValueNotifier('USD');

  final ValueNotifier<bool> isLoading = ValueNotifier(true);
  final ValueNotifier<bool> isUzbekistan = ValueNotifier(true);
  String? result;

  @override
  void initState() {
    super.initState();
    repository = CurrencyRepositoryImpl(APIService());
    getLatestCurrencies();
    getAllCurrencies();
    setState(() {});
  }

  void getAllCurrencies() async {
    allCurrencies = await repository.getAllCurrencies();
    getConvert(currentCity);
    isLoading.value = !isLoading.value;
    setState(() {});
  }

  void getLatestCurrencies() async {
    DateTime date = DateTime.now();
    date = date.subtract(const Duration(days: 1));
    latestAllCurrencies = await repository.getCurrencyFromDay(
      '${date.year}-${date.month}-${(date.day)}',
    );
    setState(() {});
  }

  void getConvert(ValueNotifier<String> currentCity) {
    final a = allCurrencies.where((e) => e.ccy == currentCity.value).first.rate;
    if (isUzbekistan.value) {
      result =
          '1 UZS  = ${(1 / (double.tryParse(a!) as double)).toStringAsFixed(4)} ${currentCity.value}';
      setState(() {});
    } else {
      result = '1 ${currentCity.value} =  $a UZS';
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.2, 1],
              colors: [Color(0xFFEAEAFE), Color(0xFFFFFFFF)],
            ),
          ),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
                child: Column(
                  children: [
                    const TopText(),
                    20.verticalSpace,
                    ConverterCard(
                      allCurrencies: allCurrencies,
                      currentCity: currentCity,
                      isUzbekistan: isUzbekistan,
                      getConvert: getConvert,
                    ),
                    15.verticalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomText(text: 'Ориентировочный обменный курс'),
                        CustomText(
                          text: result ?? '',
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                    15.verticalSpace,
                    CurrenciesList(
                      allCurrencies: allCurrencies,
                      latestAllCurrencies: latestAllCurrencies,
                      isLoading: isLoading,
                      onRefresh: () async {
                        isLoading.value = !isLoading.value;
                        getAllCurrencies();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
