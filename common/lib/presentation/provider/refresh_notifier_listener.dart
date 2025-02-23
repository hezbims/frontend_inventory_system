import 'package:common/presentation/provider/refresh_notifier.dart';
import 'package:dependencies/provider.dart';
import 'package:flutter/cupertino.dart';

class RefreshNotifierListener extends StatefulWidget {
  /// Lakukan sesuatu apabila `RefreshNotifier` melakukan `notifyListeners`
  final void Function(BuildContext) listener;
  final Widget Function(BuildContext) builder;

  const RefreshNotifierListener({
    required this.listener,
    required this.builder,
    super.key
  });

  @override
  State<RefreshNotifierListener> createState() => _RefreshNotifierListenerState();
}

class _RefreshNotifierListenerState extends State<RefreshNotifierListener> {


  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }


  @override
  void dispose() {
    if (context.mounted && mounted) {
      context.read<RefreshNotifier>().removeListener(_refreshListener);
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (context.mounted) {
      context.read<RefreshNotifier>().addListener(_refreshListener);
    }
  }

  void _refreshListener(){
    if (mounted && context.mounted) {
      widget.listener(context);
    }
  }
}
