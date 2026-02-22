import 'dart:async';

import 'package:common/domain/model/response_wrapper.dart';
import 'package:common/domain/repository/i_user_repository.dart';
import 'package:common/routing/my_route_state_provider.dart';
import 'package:dependencies/get_it.dart';
import 'package:dependencies/provider.dart';
import 'package:flutter/material.dart';

class ProfileButton extends StatefulWidget {
  final IUserRepository userRepository;

  /// Subscribe to logout progress state for parent component. The parent don't need to handle
  /// the logout navigation, because this component will automatically navigate to login page when
  /// logout succeed
  final void Function(ResponseWrapper<Object?, Object?> progress)? onLogoutProgressing;
  
  ProfileButton({
    super.key,
    IUserRepository? userRepository,
    this.onLogoutProgressing,
  }) : userRepository = userRepository ?? GetIt.I.get<IUserRepository>();

  @override
  State<ProfileButton> createState() => _ProfileButtonState();
}

class _ProfileButtonState extends State<ProfileButton> {

  late final String userName;
  late final MyRouteStateProvider routeStateProvider;
  StreamSubscription<ResponseWrapper<Object?, Object?>>? logoutProgressSubscription;

  @override
  void initState() {
    super.initState();
    routeStateProvider = context.read<MyRouteStateProvider>();
    userName = widget.userRepository.getCurrentUser()?.username ??
        "Error Getting Username";
  }

  @override
  void dispose() {
    logoutProgressSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (buttonContext) {
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: OutlinedButton(
              onPressed: (){
                final RenderBox button = buttonContext.findRenderObject() as RenderBox;
                final Offset buttonTopLeft = button.localToGlobal(Offset.zero);
                final Size buttonSize = button.size;

                // Compute a RelativeRect such that the menu's top-left aligns with
                // the button's bottom-left.
                final RelativeRect position = RelativeRect.fromLTRB(
                  buttonTopLeft.dx, // left
                  buttonTopLeft.dy + buttonSize.height, // top (below the button)
                  buttonTopLeft.dx + buttonSize.width, // right (not used much here)
                  buttonTopLeft.dy, // bottom
                );

                showMenu(
                  context: context,
                  position: position,
                  items: [
                    PopupMenuItem(
                      onTap: (){
                        final logoutStream = widget.userRepository.logout();
                        subscribeToLogoutStream(logoutStream);
                      },
                      child: const Text('Logout'),
                    ),
                  ],
                );
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.black),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                foregroundColor: Colors.black,
              ),
              child: Row(
                children: [
                  const Icon(Icons.account_circle_outlined),
                  const SizedBox(width: 12,),
                  Text(widget.userRepository.getCurrentUser()?.username ?? "Error Getting Username"),
                ],
              ),
            ),
          );
        }
    );
  }
  
  void subscribeToLogoutStream(Stream<ResponseWrapper<Object?, Object?>> logoutStream){
    final parentLogoutProgressHandler = widget.onLogoutProgressing;

    logoutProgressSubscription = logoutStream.listen((data) {
      if (parentLogoutProgressHandler != null){
        parentLogoutProgressHandler(data);
      }
      if (data is ResponseSucceed){
        routeStateProvider.setStateUnauthenticated();
      }
    }, onError: (error, stacktrace){
      // TODO : perlu ada logging disini
      if (parentLogoutProgressHandler != null){
        parentLogoutProgressHandler(ResponseFailed(error: error));
      }
    });

  }
}