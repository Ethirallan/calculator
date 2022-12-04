import 'dart:convert';

import 'package:calculator/models/convert_payload/convert_payload.dart';
import 'package:calculator/models/currency/currency.dart';
import 'package:calculator/providers/http_client_provider.dart';
import 'package:calculator/providers/toast_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';

final httpProvider = Provider<HttpHelper>((ref) {
  final httpClient = ref.watch(httpClientProvider);
  return HttpHelper(http: httpClient, ref: ref);
});

class HttpHelper {
  HttpHelper({
    required this.http,
    required this.ref,
  });

  final BaseClient http;
  final Ref ref;
  final Map<String, String> headers = {
    'content-type': 'application/json',
  };

  Future<List<Currency>> getCurrencyList() async {
    List<Currency> currencyList = [];

    try {
      Response response = await http.get(
        Uri.parse('${dotenv.env['API_URL']}/currency/getCurrencyList'),
      );

      for (var el in jsonDecode(response.body.toString())) {
        currencyList.add(Currency.fromJson(el));
      }
    } catch (e) {
      ref.read(toastProvider.notifier).state = Toast(
        'Error $e',
        Colors.red,
      );
    }

    return currencyList;
  }

  Future<double?> convert(int from, int to, double amount) async {
    ConvertPayload convertPayload = ConvertPayload(
      currencyFrom: from,
      currencyTo: to,
      amount: amount,
    );
    try {
      var res = await http.post(
        Uri.parse('${dotenv.env['API_URL']}/currency/convert'),
        headers: headers,
        body: jsonEncode(convertPayload.toJson()),
      );

      if (res.statusCode == 201 && res.body.isNotEmpty) {
        return double.parse(res.body);
      }
    } catch (e) {
      ref.read(toastProvider.notifier).state = Toast(
        'Error: $e',
        Colors.red,
      );
    }
    return null;
  }
}
