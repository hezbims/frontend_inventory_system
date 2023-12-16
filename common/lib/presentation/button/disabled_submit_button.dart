import 'package:common/constant/themes/custom_sizing.dart';
import 'package:flutter/material.dart';

class DisabledSubmitButton extends StatelessWidget {
  final String label;
  const DisabledSubmitButton({
    super.key,
    this.label = "Submit",
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: CustomSizing.maxPhoneLandscapeWidth),
      child: FilledButton(
        onPressed: null,
        child: Text(label),
      ),
    );
  }


}