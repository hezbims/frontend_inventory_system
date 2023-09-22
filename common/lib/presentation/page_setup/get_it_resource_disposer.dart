import 'package:flutter/material.dart';

class GetItResourceDisposer extends StatefulWidget {
  final void Function() disposeFunction;
  final Widget child;
  const GetItResourceDisposer({
    super.key,
    required this.disposeFunction,
    required this.child,
  });

  @override
  State<GetItResourceDisposer> createState() => _GetItResourceDisposerState();
}

class _GetItResourceDisposerState extends State<GetItResourceDisposer> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    widget.disposeFunction();
    super.dispose();
  }
}
