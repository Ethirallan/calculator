import 'package:calculator/components/calc_button.dart';
import 'package:calculator/const/buttons.dart';
import 'package:calculator/const/calc_colors.dart';
import 'package:calculator/pages/currency_converter_page.dart';
import 'package:calculator/providers/calc_mode_provider.dart';
import 'package:calculator/providers/dark_mode_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:math_expressions/math_expressions.dart';

// regex for removing trailing 0s
final RegExp regex = RegExp(r'([.]*0)(?!.*\d)');

final List<String> operations = ['/', 'x', '-', '+'];

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darkMode = ref.watch(darkModeProvider);
    final calcMode = ref.watch(calcModeProvider);

    final result = useState<String>('');
    final equation = useState<String>('');

    bool containsOperation(String equation) {
      return equation.contains('+') ||
          equation.contains('-') ||
          equation.contains('/') ||
          equation.contains('x');
    }

    void goToCurrencyConverter() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const CurrencyConverterPage(),
        ),
      );
    }

    void changeCalcMode() {
      ref.read(calcModeProvider.notifier).update((state) {
        if (state == CalcMode.basic) {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.landscapeRight,
            DeviceOrientation.landscapeLeft
          ]);
          return CalcMode.advanced;
        } else {
          SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
          return CalcMode.basic;
        }
      });
      result.value = '';
      equation.value = '';
    }

    void toggleDarkMode() {
      ref.read(darkModeProvider.notifier).toggleAppTheme(ref);
    }

    processTap(String label) {
      switch (label) {
        case '=':
          // Calc res and display it
          if (containsOperation(equation.value)) {
            Parser p = Parser();
            Expression exp = p.parse(equation.value.replaceAll('x', '*'));
            ContextModel cm = ContextModel();
            double eval = exp.evaluate(EvaluationType.REAL, cm);

            result.value = eval.toString().replaceAll(regex, '');
          }
          break;
        case 'AC':
          // Clear res and equation
          equation.value = '';
          result.value = '';
          break;

        case '⌫':
          // Delete last char from equation
          if (equation.value == '') return;
          equation.value =
              equation.value.substring(0, equation.value.length - 1);
          result.value = '';
          break;
        case '.':
          if (equation.value == '') return;

          String lastChar = equation.value.substring(
            equation.value.length - 1,
            equation.value.length,
          );

          if (lastChar == '.') return;
          // TODO: check if number already contains a "."
          equation.value += label;
          result.value = '';
          break;
        default:
          if (operations.contains(label)) {
            if (equation.value == '') return;
            if (calcMode == CalcMode.basic &&
                containsOperation(equation.value)) {
              return;
            }

            String lastChar = equation.value.substring(
              equation.value.length - 1,
              equation.value.length,
            );

            if (operations.contains(lastChar)) return;
            equation.value += label;
            result.value = '';
          } else {
            equation.value += label;
            result.value = '';
          }
          break;
      }
    }

    return Scaffold(
      backgroundColor:
          darkMode ? CalcColors.backgroundDark : CalcColors.background,
      body: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (orientation != Orientation.landscape)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: goToCurrencyConverter,
                        icon: const Icon(Icons.currency_exchange),
                        color: darkMode
                            ? CalcColors.operatorLabelDark
                            : CalcColors.operatorLabel,
                      ),
                      TextButton(
                        onPressed: changeCalcMode,
                        child: Text(
                          calcMode == CalcMode.basic ? 'BSC' : 'ADV',
                          style: TextStyle(
                            color: darkMode
                                ? CalcColors.operatorLabelDark
                                : CalcColors.operatorLabel,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: toggleDarkMode,
                        icon: Icon(
                          darkMode ? Icons.sunny : Icons.nightlight,
                        ),
                        color: darkMode
                            ? CalcColors.operatorLabelDark
                            : CalcColors.operatorLabel,
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
                          result.value,
                          style: TextStyle(
                            fontSize: 60,
                            color: darkMode
                                ? CalcColors.resultDark
                                : CalcColors.result,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          equation.value,
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
                    child: orientation == Orientation.landscape &&
                            calcMode == CalcMode.advanced
                        ? GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 12,
                            ),
                            itemBuilder: (_, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8),
                                child: CalcButton(
                                  label: landscapeButtons[index],
                                  onTap: () =>
                                      processTap(landscapeButtons[index]),
                                  landscape: true,
                                ),
                              );
                            },
                            itemCount: landscapeButtons.length,
                          )
                        : Wrap(
                            spacing: 20,
                            runSpacing: 20,
                            children: [
                              for (String button in buttons)
                                CalcButton(
                                  label: button,
                                  onTap: () => processTap(button),
                                  landscape: false,
                                ),
                            ],
                          ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
