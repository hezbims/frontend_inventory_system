import 'package:common/constant/themes/custom_sizing.dart';
import 'package:flutter/material.dart';

class ConstrainedWidthCenter extends StatelessWidget {
  final Widget _child;
  const ConstrainedWidthCenter({
    super.key,
    required Widget child,
  }) : _child = child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: CustomSizing.maxLayoutWidth),
        child: _child,
      ),
    );
  }
}