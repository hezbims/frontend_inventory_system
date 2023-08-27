import 'package:flutter/material.dart';

class SubmitButton extends FilledButton {
  final void Function()? onTap;
  final String label;
  SubmitButton({
    super.key,
    required this.onTap,
    this.label = "Submit",
  }) : super(
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
  );
}