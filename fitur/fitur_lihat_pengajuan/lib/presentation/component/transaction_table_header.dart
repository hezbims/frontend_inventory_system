import 'package:common/presentation/styling/color/my_colors.dart';
import 'package:flutter/material.dart';

class TransactionTableHeader extends StatelessWidget {
  const TransactionTableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final textAlignments = [TextAlign.center, TextAlign.center, TextAlign.left, TextAlign.left, TextAlign.center, TextAlign.center];
    final labels = ["No", "Type", "Name", "Code", "Status", "Action"];
    final List<double> paddings = [0, 0, 24, 0, 0, 0];
    final List<double> widths = [60, 100, 363, 210, 154, 113];

    return Row(
        children: [
          for (int i = 0 ; i < 6 ; i++)
            Container(
              width: widths[i],
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: paddings[i]),
              color: MyColors.primary1,
              child: Text(
                labels[i],
                textAlign: textAlignments[i],
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w200
                ),
              ),
            ),
        ]
    );
  }
}
