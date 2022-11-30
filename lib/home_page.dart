import 'package:calculator/components/calc_button.dart';
import 'package:calculator/const/calc_colors.dart';
import 'package:calculator/providers/dark_mode_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:math_expressions/math_expressions.dart';

final resultProvider = StateProvider<String>((ref) => '');
final equationProvider = StateProvider<String>((ref) => '');

class HomePage extends HookConsumerWidget {
  HomePage({super.key});

  // regex for removing trailing 0s
  RegExp regex = RegExp(r'([.]*0)(?!.*\d)');

  final List<String> buttons = [
    'AC',
    '⌫',
    '%',
    '/',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '0',
    '.',
    '=',
  ];

  List<String> operations = ['/', 'x', '-', '+'];

  bool containsOperation(String equation) {
    return equation.contains('+') ||
        equation.contains('-') ||
        equation.contains('/') ||
        equation.contains('x');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darkMode = ref.watch(darkModeProvider);
    final dmProvider = ref.watch(darkModeProvider.notifier);

    processTap(String label) {
      String tempValue = ref.read(equationProvider);

      if (label == '=') {
        // Calc res and display it
        if (containsOperation(tempValue)) {
          Parser p = Parser();
          Expression exp = p.parse(tempValue.replaceAll('x', '*'));
          ContextModel cm = ContextModel();
          double eval = exp.evaluate(EvaluationType.REAL, cm);

          ref
              .read(resultProvider.notifier)
              .update((state) => eval.toString().replaceAll(regex, ''));
        }
      } else if (label == 'AC') {
        // Clear res and equation
        ref.read(equationProvider.notifier).update((state) => '');
        ref.read(resultProvider.notifier).update((state) => '');
      } else if (label == '⌫') {
        // Delete last char from equation
        if (tempValue == '') return;

        ref.read(equationProvider.notifier).update(
              (state) => state.substring(0, state.length - 1),
            );
        ref.read(resultProvider.notifier).update((state) => '');
      } else if (label == '%') {
        // TODO: imlement this feature
        // ref.read(equationProvider.notifier).update((state) => state);
        // ref.read(resultProvider.notifier).update((state) => '');
      } else if (label == '.') {
        if (tempValue == '') return;

        String lastChar = tempValue.substring(
          tempValue.length - 1,
          tempValue.length,
        );

        if (lastChar == '.') return;
        // TODO: check if number already contains a "."
        ref.read(equationProvider.notifier).update((state) => state + label);
        ref.read(resultProvider.notifier).update((state) => '');
      } else if (operations.contains(label)) {
        if (tempValue == '' || containsOperation(tempValue)) return;

        String lastChar = tempValue.substring(
          tempValue.length - 1,
          tempValue.length,
        );

        if (operations.contains(lastChar)) return;
        ref.read(equationProvider.notifier).update((state) => state + label);
        ref.read(resultProvider.notifier).update((state) => '');
      } else {
        ref.read(equationProvider.notifier).update((state) => state + label);
        ref.read(resultProvider.notifier).update((state) => '');
      }
    }

    return Scaffold(
      backgroundColor:
          darkMode ? CalcColors.backgroundDark : CalcColors.background,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    dmProvider.toggleAppTheme(ref);
                  },
                  icon: Icon(
                    darkMode ? Icons.sunny : Icons.nightlight,
                  ),
                  color: darkMode ? CalcColors.operatorLabelDark : CalcColors.operatorLabel,
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Spacer(),
                    Text(
                      ref.watch(resultProvider),
                      style: TextStyle(
                        fontSize: 60,
                        color: darkMode
                            ? CalcColors.resultDark
                            : CalcColors.result,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      ref.watch(equationProvider),
                      style: TextStyle(
                        fontSize: 22,
                        color: darkMode
                            ? CalcColors.equationDark
                            : CalcColors.equation,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    for (String button in buttons)
                      CalcButton(
                        label: button,
                        onTap: () => processTap(button),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
