import 'package:common/constant/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:inventory_system/routing/on_generate_route.dart';
import 'package:inventory_system/routing/route_arg.dart';

List<Route<dynamic>> onGenerateInitialRoutes(String path){
  final uri = Uri.parse(path);
  final urlPathSegments = uri.pathSegments;

  if (urlPathSegments.isEmpty){
    final nextPath = onGenerateRoute(
      const RouteSettings(
        name: '/'
      )
    );
    return [nextPath!];
  } else if (urlPathSegments.first == RoutesName.loginName){
    return [
      onGenerateRoute(
        const RouteSettings(
          name: '/${RoutesName.loginName}'
        )
      )!
    ];

  } else {
    var currentPath = '';
    var listRoute = <Route<dynamic>>[];
    for (int i = 0 ; i < urlPathSegments.length ; i++){
      final urlPathSegment = urlPathSegments[i];
      currentPath += '/$urlPathSegment';


      listRoute.add(
        onGenerateRoute(
          RouteSettings(
            name: currentPath,
            arguments: i + 1 == urlPathSegments.length ?
                UseRouteGuardArg.useRouteGuard : UseRouteGuardArg.noRouteGuard
          )
        )!
      );
    }
    return listRoute;
  }
}