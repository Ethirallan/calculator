import 'package:calculator/const/calc_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConverterInputField extends StatefulWidget {
  const ConverterInputField({
    Key? key,
    required this.label,
    required this.darkMode,
    required this.amountCtrl,
    required this.onPressed,
  }) : super(key: key);

  final String label;
  final bool darkMode;
  final TextEditingController amountCtrl;
  final VoidCallback onPressed;

  @override
  State<ConverterInputField> createState() => _ConverterInputFieldState();
}

class _ConverterInputFieldState extends State<ConverterInputField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        color: widget.darkMode ? CalcColors.resultDark : CalcColors.result,
      ),
      decoration: InputDecoration(
        suffixIcon: widget.amountCtrl.text.isNotEmpty
            ? IconButton(
                onPressed: () {
                  widget.onPressed.call();
                  setState(() {});
                },
                icon: const Icon(Icons.clear),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color:
                widget.darkMode ? CalcColors.equationDark : CalcColors.equation,
          ),
        ),
        label: Text(widget.label),
        labelStyle: TextStyle(
          color:
              widget.darkMode ? CalcColors.equationDark : CalcColors.equation,
        ),
      ),
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          RegExp(r'^(\d+)?\.?\d{0,2}'),
        ),
        FilteringTextInputFormatter.allow(
          RegExp(r'^\d+\.?\d*'),
        ),
      ],
      onChanged: (String? newVal) {
        setState(() {});
      },
      controller: widget.amountCtrl,
      keyboardType: const TextInputType.numberWithOptions(
        decimal: true,
      ),
    );
  }
}
