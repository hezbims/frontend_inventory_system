import 'package:common/presentation/api_loader/default_error_widget.dart';
import 'package:common/response/api_response.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_autentikasi/presentation/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:stock_bu_fan/routing/route_guard_provider.dart';

class RouteGuard extends StatelessWidget {
  final Widget displayedPage;
  const RouteGuard({
    super.key , required this.displayedPage
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<RouteGuardProvider>(
      builder: (context , provider , child) {
        return FutureBuilder(
          future: provider.getCurrentSessionTokenResponse,
          builder: (context , snapshot){
            if (snapshot.hasData){
              final data = snapshot.data!;

              if (data is ApiResponseFailed){
                // berarti gagal tersambung ke server
                if (data.statusCode == null){
                  return DefaultErrorWidget(
                    onTap: provider.refresh,
                    errorMessage: data.error.toString(),
                  );
                }
                // Berarti local token sekarang enggak valid atau belum ada local token
                else if (data.statusCode == 401){
                  return LoginScreen(
                    setCurrentSessionToken: provider.setCurrentSessionToken,
                  );
                }
                else {
                  throw Exception('Get Current User ngedapetin status yang enggak diketahui');
                }
              }
              else if (data is ApiResponseSuccess<String>){
                return displayedPage;
              }
              else { throw Exception('Unknown Api Response Route Gurad'); }

            }
            else {
              return const Center(child: CircularProgressIndicator(),);
            }
          }
        );
      }
    );
  }
}
