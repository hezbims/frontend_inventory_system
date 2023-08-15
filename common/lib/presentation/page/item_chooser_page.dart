import 'package:flutter/material.dart';

class ItemChooserPage extends StatelessWidget {
  final ChangeNotifier Function(BuildContext) onCreateProvider;
  final AppBar appBar;


  const ItemChooserPage({
    required this.onCreateProvider,
    required this.appBar,

    super.key
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
