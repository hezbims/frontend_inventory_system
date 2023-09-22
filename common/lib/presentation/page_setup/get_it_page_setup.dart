import 'package:common/presentation/page_setup/get_it_resource_disposer.dart';
import 'package:flutter/material.dart';

class GetItPageSetup {
  final void Function() _setup;
  final void Function() _disposeFunction;
  final Widget _page;

  /// Menyiapkan dependency yang diperlukan dan auto resource disposal ketika
  /// page ditutup
  Widget getPage() {
    _setup();
    return GetItResourceDisposer(
      disposeFunction: _disposeFunction,
      child: _page,
    );
}

  GetItPageSetup({
    required void Function() setup,
    required void Function() disposeFunction,
    required Widget page,
  }) : _setup = setup,
        _page = page,
        _disposeFunction = disposeFunction;
}