import 'package:common/constant/themes/custom_sizing.dart';
import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final void Function()? onTap;
  final String label;
  const SubmitButton({
    super.key,
    required this.onTap,
    this.label = "Submit",
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: CustomSizing.maxPhoneLandscapeWidth),
      child: FilledButton(
        onPressed: onTap,
        child:
        onTap == null ?
        const SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ) :
        Text(label),
      ),
    );
  }
}