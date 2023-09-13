import 'package:flutter/material.dart';

class PageSetup {
  final void Function() _setup;
  final Widget _page;
  Widget getPage() {
    _setup();
    return _page;
}

  PageSetup({
    required void Function() setup,
    required Widget page,
  }) : _setup = setup, _page = page;
}