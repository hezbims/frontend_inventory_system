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
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children : [
          const Icon(Icons.warning , size: 48,),

          Text(
            errorMessage,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 8,),

          ElevatedButton(
            onPressed: onTap,
            child: const Text("Refersh"),
          )
        ]
      ),
    );
  }
}
