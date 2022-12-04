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

      switch (response.statusCode) {
        case 200:
          for (var el in jsonDecode(response.body.toString())) {
            currencyList.add(Currency.fromJson(el));
          }
          break;
        case 403:
          ref.read(toastProvider.notifier).state = const Toast(
            'Error: Access Denied',
            Colors.red,
          );
          break;
        default:
          ref.read(toastProvider.notifier).state = const Toast(
            'An error occurred. Please try again later.',
            Colors.red,
          );
      }
    } catch (e) {
      ref.read(toastProvider.notifier).state = const Toast(
        'An error occurred. Please try again later.',
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
      Response response = await http.post(
        Uri.parse('${dotenv.env['API_URL']}/currency/convert'),
        headers: headers,
        body: jsonEncode(convertPayload.toJson()),
      );

      switch (response.statusCode) {
        case 201:
          if (response.body.isNotEmpty) {
            return double.parse(response.body);
          } else {
            ref.read(toastProvider.notifier).state = const Toast(
              'An error occurred. Please try again later.',
              Colors.red,
            );
          }
          break;
        case 403:
          ref.read(toastProvider.notifier).state = const Toast(
            'Error: Access Denied',
            Colors.red,
          );
          break;
        default:
          ref.read(toastProvider.notifier).state = const Toast(
            'An error occurred. Please try again later.',
            Colors.red,
          );
      }
    } catch (e) {
      ref.read(toastProvider.notifier).state = const Toast(
        'An error occurred. Please try again later.',
        Colors.red,
      );
    }
    return null;
  }
}
