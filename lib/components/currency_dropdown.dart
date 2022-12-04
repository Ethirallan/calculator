import 'package:calculator/const/calc_colors.dart';
import 'package:calculator/models/currency/currency.dart';
import 'package:flutter/material.dart';

class CurrencyDropdown extends StatelessWidget {
  const CurrencyDropdown({
    Key? key,
    required this.label,
    required this.currency,
    required this.currencyList,
    required this.darkMode,
  }) : super(key: key);

  final String label;
  final ValueNotifier<Currency?> currency;
  final List<Currency> currencyList;
  final bool darkMode;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Currency>(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: darkMode ? CalcColors.equationDark : CalcColors.equation,
          ),
        ),
        // filled: true,
        // fillColor: darkMode ? Colors.black : Colors.white,
        labelText: label,
        labelStyle: TextStyle(
          color: darkMode ? CalcColors.equationDark : CalcColors.equation,
        ),
      ),
      style: TextStyle(
        color: darkMode ? CalcColors.resultDark : CalcColors.result,
      ),
      dropdownColor:
          darkMode ? CalcColors.backgroundDark : CalcColors.background,
      value: currency.value,
      onChanged: (Currency? newCurrency) {
        if (newCurrency != null) {
          currency.value = newCurrency;
        }
      },
      items: currencyList
          .map<DropdownMenuItem<Currency>>(
            (currency) => DropdownMenuItem<Currency>(
              value: currency,
              child: Text(
                currency.label,
              ),
            ),
          )
          .toList(),
    );
  }
}
