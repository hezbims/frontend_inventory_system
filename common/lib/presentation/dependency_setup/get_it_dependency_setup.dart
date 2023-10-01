import 'package:flutter/material.dart';

class GetItDependencySetup extends StatefulWidget{
  final void Function() _setup;
  final void Function() _disposeFunction;
  final Widget _page;

  @override
  State<GetItDependencySetup> createState() => _GetItDependencySetupState();

  const GetItDependencySetup({
    super.key,
    required void Function() setup,
    required void Function() disposeFunction,
    required Widget page,
  }) : _setup = setup,
        _page = page,
        _disposeFunction = disposeFunction;
}

class _GetItDependencySetupState extends State<GetItDependencySetup> {

  @override
  void initState() {
    widget._setup();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget._page;
  }

  @override
  void dispose() {
    widget._disposeFunction();
    super.dispose();
  }
}