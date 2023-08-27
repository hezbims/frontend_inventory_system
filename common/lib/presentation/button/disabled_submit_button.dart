import 'package:flutter/material.dart';

class DisabledSubmitButton extends FilledButton {
  final String label;
  DisabledSubmitButton({
    super.key,
    this.label = "Submit",
  }) : super(
    onPressed: null,
    child: Text(label),
  );
}