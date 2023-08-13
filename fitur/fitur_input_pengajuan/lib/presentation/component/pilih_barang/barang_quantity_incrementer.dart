import 'package:common/presentation/textfield/style/text_style.dart';
import 'package:flutter/material.dart';

class BarangQuantityIncrementer extends StatelessWidget {
  final void Function() onDecrease;
  final void Function() onIncrease;
  final int currentQuantity;
  final String? errorMessage;

  const BarangQuantityIncrementer({
    super.key,
    required this.onDecrease,
    required this.onIncrease,
    required this.currentQuantity,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Quantity" , style: labelStyle,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.remove_circle),
              onPressed: onDecrease,
            ),

            Card(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                child: Text(
                  currentQuantity.toString()
                )
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add_circle),
              onPressed: onIncrease,
            ),
          ],
        ),

        if (errorMessage != null)
          Text(errorMessage! , style: const TextStyle(color: Colors.red),),
      ],
    );
  }
}
