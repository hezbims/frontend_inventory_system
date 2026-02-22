import 'dart:async';

import 'package:common/domain/model/response_wrapper.dart';
import 'package:common/presentation/loader_overlay/loader_overlay.dart';
import 'package:common/presentation/toast/i_my_toast.dart';
import 'package:dependencies/get_it.dart';
import 'package:flutter/cupertino.dart';

class StreamLoaderOverlay<T , E> extends StatelessWidget {

  final Stream<ResponseWrapper<T , E>> stream;
  final IMyToast toast;
  final Widget child;
  final void Function(ResponseFailed<T , E>)? onFailed;
  final void Function(ResponseSucceed<T , E>)? onSucceed;

  StreamLoaderOverlay({
    super.key,
    required this.stream,
    required this.child,
    IMyToast? toast,
    this.onFailed,
    this.onSucceed,
  }) : toast = toast ?? GetIt.I.get<IMyToast>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot){
        final localData = snapshot.data;
        final localOnFailed = onFailed;
        final localOnSucceed = onSucceed;

        if (snapshot.hasError){
          // TODO: perlu error logging ke ke server
          toast.showToastNonStatic(msg: "Unknown error occurs");
        }
        else if (localData is ResponseFailed<T , E> && localOnFailed != null){
          localOnFailed(localData);
        }
        else if (localData is ResponseSucceed<T , E> && localOnSucceed != null){
          localOnSucceed(localData);
        }

        return LoaderOverlay(
          isLoading: localData is ResponseLoading,
          child: child
        );
      },
    );
  }
}