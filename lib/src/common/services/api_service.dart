import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../constants/api_constants.dart';

enum Method {
  get,
  post,
  put,
  patch,
  delete,
}

class APIService {
  factory APIService() => _;

  const APIService._instance();

  static const _ = APIService._instance();

  Future<String> request(
      requestPath, {
        Method method = Method.get,
        Map<String, List<String>> queryParametersAll = const {},
        Map<String, String> headers = const {},
        Map<String, Object?> body = const {},
      }) async {
    final params = _queryToString(queryParametersAll);
    final Uri uri = Uri.parse('${ApiConst.baseUrl}$requestPath$params');

    try {
      Response response = await switch (method) {
        Method.get => get(uri, headers: headers),
        Method.post => post(uri, headers: headers, body: body),
        Method.put => put(uri, headers: headers, body: body),
        Method.patch => patch(uri, headers: headers, body: body),
        Method.delete => delete(uri, headers: headers),
      }
          .timeout(const Duration(seconds: 10));

      return switch (response.statusCode) {
        < 200 => throw Error.throwWithStackTrace(
          '${response.reasonPhrase}',
          StackTrace.current,
        ),
        <= 200 && <= 299 => response.body,
        >= 300 && < 400 => throw Error.throwWithStackTrace(
          '${response.reasonPhrase}',
          StackTrace.current,
        ),
        >= 400 && < 500 => throw Error.throwWithStackTrace(
          'Client error',
          StackTrace.current,
        ),
        >= 500 => throw Error.throwWithStackTrace(
          'Server error',
          StackTrace.current,
        ),
        _ => throw Error.throwWithStackTrace(
          'Unexpected Error',
          StackTrace.current,
        ),
      };
    } on TimeoutException catch (e, stackTrace) {
      debugPrint('$e\n$stackTrace');
      return throw Error.throwWithStackTrace(
        'Check your network',
        StackTrace.current,
      );
    } catch (e, stackTrace) {
      debugPrint('$e\n$stackTrace');
      rethrow;
    }
  }

  String _queryToString(Map<String, List<String>> query) => query.isEmpty
      ? ""
      : "?${query.entries.map<List<String>>((e) => e.value.map((v) => "${e.key}=$v").toList()).map<String>((e) => e.join("&")).join("&")}";
}
