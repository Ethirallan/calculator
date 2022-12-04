import 'package:calculator/components/converter_button.dart';
import 'package:calculator/components/converter_input_field.dart';
import 'package:calculator/components/currency_dropdown.dart';
import 'package:calculator/const/calc_colors.dart';
import 'package:calculator/models/currency/currency.dart';
import 'package:calculator/providers/currency_list_provider.dart';
import 'package:calculator/providers/dark_mode_provider.dart';
import 'package:calculator/providers/http_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CurrencyConverterPage extends HookConsumerWidget {
  const CurrencyConverterPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darkMode = ref.watch(darkModeProvider);
    final currencyList = ref.read(currencyListProvider);
    final currencyFrom = useState<Currency?>(null);
    final currencyTo = useState<Currency?>(null);
    final amountCtrl = useTextEditingController();
    final result = useState<double?>(null);

    final getDataFuture = useMemoized(() async {
      await ref.read(currencyListProvider.notifier).getCurrencyList();
    });

    final snapshot = useFuture(getDataFuture);

    goBack() {
      Navigator.of(context).pop();
    }

    convert() async {
      if (amountCtrl.text.isNotEmpty &&
          currencyFrom.value != null &&
          currencyTo.value != null) {
        result.value = await ref.read(httpProvider).convert(
              currencyFrom.value!.id,
              currencyTo.value!.id,
              double.parse(amountCtrl.text),
            );
      }
    }

    clearAmountInput() {
      amountCtrl.clear();
      result.value = null;
      FocusManager.instance.primaryFocus?.unfocus();
    }

    return Scaffold(
      backgroundColor:
          darkMode ? CalcColors.backgroundDark : CalcColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: IconButton(
                    onPressed: goBack,
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: darkMode
                          ? CalcColors.operatorLabelDark
                          : CalcColors.operatorLabel,
                    ),
                  ),
                ),
                Text(
                  'Currency converter',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: darkMode ? CalcColors.resultDark : CalcColors.result,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(
                  width: 58,
                ),
              ],
            ),
            Builder(
              builder: (context) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // currencyFrom.value = currencyList[0];
                  // currencyTo.value = currencyList[1];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: CurrencyDropdown(
                                label: 'From',
                                currency: currencyFrom,
                                currencyList: currencyList,
                                darkMode: darkMode,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Icon(
                                Icons.arrow_forward,
                                color: darkMode
                                    ? CalcColors.equationDark
                                    : CalcColors.equation,
                              ),
                            ),
                            Expanded(
                              child: CurrencyDropdown(
                                label: 'To',
                                currency: currencyTo,
                                currencyList: currencyList,
                                darkMode: darkMode,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: ConverterInputField(
                          label: 'Amount',
                          darkMode: darkMode,
                          amountCtrl: amountCtrl,
                          onPressed: clearAmountInput,
                        ),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      Text(
                        result.value?.toStringAsFixed(5) ?? '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: darkMode
                              ? CalcColors.resultDark
                              : CalcColors.result,
                          fontSize: 60,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: ConverterButton(
                          label: 'CONVERT',
                          onTap: convert,
                        ),
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        darkMode
                            ? CalcColors.equalsBackgroundDark
                            : CalcColors.equalsBackground,
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
