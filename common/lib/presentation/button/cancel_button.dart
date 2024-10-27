import 'package:common/constant/themes/custom_sizing.dart';
import 'package:flutter/material.dart';

class CancelButton extends StatelessWidget {
  final String label;
  final void Function() _onPressed;
  const CancelButton({
    this.label = "Cancel",
    required void Function() onPressed,
    super.key,
  }) : _onPressed = onPressed;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: CustomSizing.maxPhoneLandscapeWidth),
      child: FilledButton(
        onPressed: _onPressed,
        style: const ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Color(0xFFC5C3C3)),
          foregroundColor: WidgetStatePropertyAll(Colors.black),
        ),
        child: Text(label,)
      ),
    );
  }
}