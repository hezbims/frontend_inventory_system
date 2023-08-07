import 'package:flutter/material.dart';

class DefaultErrorWidget extends StatelessWidget {
  final void Function() onTap;
  final String errorMessage;
  const DefaultErrorWidget({
    required this.onTap,
    required this.errorMessage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment : MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children : [
        const Icon(Icons.warning),

        Text(
          errorMessage,
          textAlign: TextAlign.center,
        ),

        ElevatedButton(
          onPressed: onTap,
          child: const Text("Refersh"),
        )
      ]
    );
  }
}
