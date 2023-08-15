import 'dart:convert';

import '../../../common/constants/api_constants.dart';
import '../../../common/services/api_service.dart';
import '../model/currency_model.dart';

abstract interface class ICurrencyRepository {
  const ICurrencyRepository();

  Future<List<Currency>> getAllCurrencies();

  Future<List<Currency>> getCurrencyFromDay(String date);

  Future<Currency> getCurrencyFromId(String id);
}

class CurrencyRepositoryImpl implements ICurrencyRepository {
  final APIService apiService;

  const CurrencyRepositoryImpl(this.apiService);

  @override
  Future<List<Currency>> getAllCurrencies() async {
    String response = await apiService.request(ApiConst.allCurrencyPath);

    List<dynamic> a = jsonDecode(response);

    List<Currency> allCurrencies = a.map((e) => Currency.fromJson(e)).toList();

    return allCurrencies;
  }

  @override
  Future<Currency> getCurrencyFromId(String id) async {
    String response = await apiService.request(
      ApiConst.getUserFromId(id),
    );

    Currency user =
        Currency.fromJson(List.from(jsonDecode(response) as List).first);
    return user;
  }

  @override
  Future<List<Currency>> getCurrencyFromDay(String date) async {
    String response = await apiService.request(ApiConst.latestCurrencies(date));

    List<dynamic> latestCurrencies = jsonDecode(response);

    List<Currency> allCurrencies =
        latestCurrencies.map((e) => Currency.fromJson(e)).toList();

    return allCurrencies;
  }
}
