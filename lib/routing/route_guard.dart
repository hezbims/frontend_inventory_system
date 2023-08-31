import 'package:common/data/repository/token_manager.dart';
import 'package:fitur_autentikasi/presentation/login_screen.dart';
import 'package:flutter/material.dart';

class RouteGuard extends StatelessWidget {
  final Widget child;
  const RouteGuard({
    super.key , required this.child
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: TokenManager.getTokenizedHeader(),
      builder: (context , snapshot){
        if (snapshot.hasData){
          if (snapshot.data!['Authorization'] == null){
            return const LoginScreen();
          }
          return child;
        }
        return const Center(child: CircularProgressIndicator(),);
      }
    );
  }
}
