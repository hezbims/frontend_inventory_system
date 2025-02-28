import 'package:common/presentation/color/my_colors.dart';
import 'package:flutter/material.dart';

class PageNumberUiController extends StatelessWidget {
  final int currentPage;
  final bool hasNextPage;
  final bool hasPrevPage;
  final void Function() onClickForward;
  final void Function() onClickBackward;
  final void Function() onClickLatest;
  final void Function() onClickFirst;

  const PageNumberUiController({
    required this.currentPage,
    required this.hasNextPage,
    required this.hasPrevPage,
    required this.onClickForward,
    required this.onClickBackward,
    required this.onClickFirst,
    required this.onClickLatest,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: hasPrevPage ? onClickFirst : null,
          customBorder: const CircleBorder(),
          child: Icon(
            Icons.keyboard_double_arrow_left,
            color: hasPrevPage ? null : MyColors.disabled1,
          ),
        ),
        InkWell(
          onTap: hasPrevPage ? onClickBackward : null,
          customBorder: const CircleBorder(),
          child: Icon(
            Icons.keyboard_arrow_left,
            color: hasPrevPage ? null : MyColors.disabled1,
          ),
        ),

        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 12, horizontal: 16,
          ),
          decoration: BoxDecoration(
            border: Border.all(width: 0.1)
          ),
          child: Text(
            currentPage.toString(),
            textAlign: TextAlign.center,
          ),
        ),

        InkWell(
          onTap: hasNextPage ? onClickForward : null,
          customBorder: const CircleBorder(),
          child: Icon(
            Icons.keyboard_arrow_right,
            color: hasNextPage ? null : MyColors.disabled1,
          ),
        ),
        InkWell(
          onTap: hasNextPage ? onClickLatest : null,
          customBorder: const CircleBorder(),
          child: Icon(
            Icons.keyboard_double_arrow_right,
            color: hasNextPage ? null : MyColors.disabled1,
          ),
        ),
      ],
    );
  }
}
