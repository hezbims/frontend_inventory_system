import 'package:common/presentation/styling/color/my_colors.dart';
import 'package:flutter/material.dart';

class RefreshTransactionDialog extends StatelessWidget {
  final void Function() onRefresh;
  final bool isDisplayed;
  const RefreshTransactionDialog({
    required this.onRefresh,
    required this.isDisplayed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (!isDisplayed) {
      return const SizedBox();
    }
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEBEBEB),
        borderRadius: BorderRadius.circular(1),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFA7A7A7),
            blurRadius: 4,
            spreadRadius: 2,
            offset: Offset(0, 2),
          ),
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Transaction History Updated',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              Text('Refresh to see the latest update')
            ],
          ),

          const SizedBox(height: 18,),

          FilledButton(
            onPressed: onRefresh,
            style: FilledButton.styleFrom(
              backgroundColor: MyColors.primary3,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3)
              ),
              textStyle: const TextStyle(color: Colors.white)
            ),
            child: const Text("Refresh"),
          )
        ],
      ),
    );
  }
}
