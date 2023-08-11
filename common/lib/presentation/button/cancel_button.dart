import 'package:flutter/material.dart';

class CancelButton extends FilledButton {
  final String label;
  CancelButton({
    this.label = "Cancel",
    required super.onPressed,
    super.key,
  }) : super(
    child: Text(label,),
    style: const ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(Color(0xFFC5C3C3)),
      foregroundColor: MaterialStatePropertyAll(Colors.black),
    )
  );
}