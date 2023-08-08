import 'package:flutter/material.dart';

class SubmitButton extends FilledButton {
  final void Function()? onTap;
  const SubmitButton({
    super.key,
    required this.onTap,
  }) : super(
    onPressed: onTap,
    child: const Text("Submit"),
  );
}