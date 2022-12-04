import 'package:calculator/const/calc_colors.dart';
import 'package:calculator/providers/dark_mode_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ConverterButton extends HookConsumerWidget {
  const ConverterButton({
    Key? key,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darkMode = ref.watch(darkModeProvider);
    final tapped = useState<bool>(false);

    return GestureDetector(
      onTap: () async {
        tapped.value = true;
        onTap.call();
        Future.delayed(const Duration(milliseconds: 100), () {
          tapped.value = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        height: 44,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: darkMode
              ? CalcColors.equalsBackgroundDark
              : CalcColors.equalsBackground,
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
              color: darkMode
                  ? CalcColors.equalsLabelDark
                  : CalcColors.equalsLabel,
              fontSize: 22,
            ),
          ),
        ),
      ),
    );
  }
}
