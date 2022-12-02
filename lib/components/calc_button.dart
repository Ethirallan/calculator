import 'package:calculator/const/calc_colors.dart';
import 'package:calculator/providers/dark_mode_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CalcButton extends HookConsumerWidget {
  CalcButton(
      {Key? key,
      required this.label,
      required this.onTap,
      required this.landscape})
      : super(key: key);

  final String label;
  final VoidCallback onTap;
  final bool landscape;

  final List<String> _operators = ['AC', '⌫', '%', '/', 'x', '-', '+', '='];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darkMode = ref.watch(darkModeProvider);
    final tapped = useState<bool>(false);
    Color getLabelColor() {
      if (label == '=') {
        return darkMode ? CalcColors.equalsLabelDark : CalcColors.equalsLabel;
      }
      if (_operators.contains(label)) {
        return darkMode
            ? CalcColors.operatorLabelDark
            : CalcColors.operatorLabel;
      }
      return darkMode ? CalcColors.labelDark : CalcColors.label;
    }

    Color getBackgroundColor() {
      if (label == '=') {
        return CalcColors.equalsBackground;
      }
      return darkMode ? CalcColors.backgroundDark : CalcColors.background;
    }

    return GestureDetector(
      onTap: () async {
        if (label.isEmpty || label == '%') return;
        tapped.value = true;
        onTap.call();
        Future.delayed(const Duration(milliseconds: 100), () {
          tapped.value = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        height: landscape
            ? double.infinity
            : (MediaQuery.of(context).size.width - 100) / 4,
        width: landscape
            ? double.infinity
            : label == '='
                ? (MediaQuery.of(context).size.width - 50) / 2
                : (MediaQuery.of(context).size.width - 100) / 4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: getBackgroundColor(),
          boxShadow: [
            BoxShadow(
              color: darkMode ? Colors.grey.shade800 : Colors.grey.shade100,
              blurRadius: 2,
              spreadRadius: -1,
              offset: Offset(0, tapped.value ? 0 : -4),
            ),
            BoxShadow(
              color: darkMode ? Colors.grey.shade900 : Colors.grey.shade400,
              blurRadius: 2,
              spreadRadius: -1,
              offset: Offset(0, tapped.value ? 0 : 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: getLabelColor(),
              fontSize: 30,
            ),
          ),
        ),
      ),
    );
  }
}
