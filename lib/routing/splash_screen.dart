import 'dart:io';

import 'package:common/domain/model/user.dart';
import 'package:common/presentation/api_loader/default_error_widget.dart';
import 'package:common/response/api_response.dart';
import 'package:common/routing/my_route_state_provider.dart';
import 'package:dependencies/provider.dart';
import 'package:flutter/material.dart';
import 'package:inventory_system/routing/splash_screen_provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SplashScreenProvider(),
      child: Consumer<SplashScreenProvider>(
        builder: (context , provider , child){
          return Scaffold(
            body: FutureBuilder(
              future: provider.getUserResponse,
              builder: (context , snapshot){
                if (snapshot.connectionState == ConnectionState.done){
                  final routeStateProvider = context.read<MyRouteStateProvider>();
                  final data = snapshot.data!;
                  if (data is ApiResponseFailed){
                    if (data.statusCode == null){
                      return Center(
                        child: DefaultErrorWidget(
                          onTap: provider.retry,
                          errorMessage: '${data.error}'
                        ),
                      );
                    }
                    else {
                      assert(data.statusCode == HttpStatus.unauthorized);
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        routeStateProvider.setStateUnauthenticated(
                          nextRouteState: null
                        );
                      });

                    }
                  } else {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      routeStateProvider.onLogin(
                          (data as ApiResponseSuccess<User>).data!
                      );
                    });
                  }
                }
                return const Center(
                  child : CircularProgressIndicator()
                );
              }
            ),
          );
        }
      ),
    );
  }
}
