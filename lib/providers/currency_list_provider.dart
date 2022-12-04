import 'package:calculator/models/currency/currency.dart';
import 'package:calculator/providers/http_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final currencyListProvider =
    StateNotifierProvider<CurrencyListNotifier, List<Currency>>((ref) {
  return CurrencyListNotifier(ref);
});

class CurrencyListNotifier extends StateNotifier<List<Currency>> {
  CurrencyListNotifier(
    this.ref, [
    List<Currency>? currencyList,
  ]) : super(currencyList ?? []) {
    getCurrencyList();
  }

  final Ref ref;

  Future<void> getCurrencyList() async {
    try {
      state = await ref.read(httpProvider).getCurrencyList();
    } catch (e) {
      state = [];
      print('get currencyList error $e');
    }
  }
}
