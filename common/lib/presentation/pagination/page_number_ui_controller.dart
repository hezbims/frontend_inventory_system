import 'package:flutter/material.dart';

class PageNumberUiController extends StatelessWidget {
  final int pageNumber;
  final void Function() onClickForward;
  final void Function() onClickBackward;
  final void Function() onClickLatest;
  final void Function() onClickFirst;

  const PageNumberUiController({
    required this.pageNumber,
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
          onTap: onClickFirst,
          customBorder: const CircleBorder(),
          child: const Icon(Icons.keyboard_double_arrow_left),
        ),
        InkWell(
          onTap: onClickBackward,
          customBorder: const CircleBorder(),
          child: const Icon(Icons.keyboard_arrow_left),
        ),

        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 12, horizontal: 16,
          ),
          decoration: BoxDecoration(
            border: Border.all(width: 0.1)
          ),
          child: Text(
            pageNumber.toString(),
            textAlign: TextAlign.center,
          ),
        ),

        InkWell(
          onTap: onClickForward,
          customBorder: const CircleBorder(),
          child: const Icon(Icons.keyboard_arrow_right),
        ),
        InkWell(
          onTap: onClickLatest,
          customBorder: const CircleBorder(),
          child: const Icon(Icons.keyboard_double_arrow_right),
        ),
      ],
    );
  }
}
