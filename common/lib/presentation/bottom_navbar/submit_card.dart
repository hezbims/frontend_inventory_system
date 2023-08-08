import 'package:common/presentation/button/submit_button.dart';
import 'package:flutter/material.dart';

class SubmitCard extends StatelessWidget {
  final void Function()? onTap;
  const SubmitCard({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.grey,
                offset: Offset(0 , -0.1),
                blurRadius: 8
            )
          ]
      ),
      child: Card(
        shadowColor: Colors.grey,
        surfaceTintColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(12),
            )
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              right: 24,
              left: 24,
              bottom: 36,
              top: 16
          ),
          child: SubmitButton(
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
