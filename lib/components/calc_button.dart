import 'package:flutter/material.dart';

class CalcButton extends StatelessWidget {
  CalcButton({Key? key, required this.label, required this.onTap})
      : super(key: key);

  final String label;
  final VoidCallback onTap;

  final List<String> _operators = ['AC', '⌫', '%', '/', 'x', '-', '+', '='];

  Color _getLabelColor() {
    if (label == '=') {
      return Colors.white;
    }
    if (_operators.contains(label)) {
      return const Color(0xFFE58E4B);
    }
    return const Color(0xFFA8A6A7);
  }

  Color _getBackgroundColor() {
    if (label == '=') {
      return const Color(0xFFE58E4B);
    }
    return const Color(0xFFEBEBEB);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: (MediaQuery.of(context).size.width - 100) / 4,
        width: label == '='
            ? (MediaQuery.of(context).size.width - 50) / 2
            : (MediaQuery.of(context).size.width - 100) / 4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: _getBackgroundColor(),
          boxShadow: [
            const BoxShadow(
              color: Colors.white,
              blurRadius: 8,
              spreadRadius: 0,
              offset: Offset(0, -4),
            ),
            BoxShadow(
              color: Colors.grey.shade500,
              blurRadius: 8,
              spreadRadius: 0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: _getLabelColor(),
              fontSize: 30,
            ),
          ),
        ),
      ),
    );
  }
}
