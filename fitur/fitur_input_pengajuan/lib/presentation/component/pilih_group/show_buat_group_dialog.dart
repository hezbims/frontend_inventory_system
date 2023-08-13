import 'package:flutter/material.dart';

Future<dynamic> showBuatGroupDialog(BuildContext context){
  return showDialog(
    context: context,
    builder: (context){
      return const _BuatGroupDialog();
    }
  );
}

class _BuatGroupDialog extends StatelessWidget {
  const _BuatGroupDialog();

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
