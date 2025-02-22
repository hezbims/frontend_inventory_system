import 'package:flutter/material.dart';

/// Membuat sebuah column bisa scrollable namun juga bisa menggunakan Expanded apabila dibutuhkan
class ScrollOrFillColumnWrapper extends StatelessWidget {
  final bool isFillMaxSize;
  final List<Widget> children;
  final EdgeInsets? padding;
  const ScrollOrFillColumnWrapper({
    required this.isFillMaxSize,
    required this.children,
    this.padding,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return isFillMaxSize ?
        Padding(
          padding: padding ?? EdgeInsets.zero,
          child: Column(
            children: children,
          ),
        ) :
        SingleChildScrollView(
          padding: padding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: children,
          ),
        );
  }
}