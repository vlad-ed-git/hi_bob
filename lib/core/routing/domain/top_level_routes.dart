import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hi_bob/core/error_handling/presentation/screens/page_not_found.dart';
import 'package:hi_bob/core/routing/domain/home_page_routes.dart';
import 'package:hi_bob/features/authentication/presentation/screens/splash_screen.dart';
import 'package:hi_bob/features/home/presentation/screens/home.dart';

enum AppRoutes {
  home('home'),
  splashScreen('welcome'),
  noRouteFound('404');
  const AppRoutes(this.routeName);

  final String routeName;
  String get path => this ==  splashScreen ? '/' : '/$routeName';

  RouteBase getRoute() {
    switch (this) {
      case AppRoutes.splashScreen:
        return GoRoute(
          path: AppRoutes.splashScreen.path,
          name: AppRoutes.splashScreen.routeName,
          builder: (BuildContext _, GoRouterState __) => const SplashScreen(),
        );
      case AppRoutes.home:
        return StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return HomeScreen(goRouterHomePageNavShell: navigationShell);
          },
          branches: homeTabs,
        );
      case AppRoutes.noRouteFound:
        return GoRoute(
          path: AppRoutes.noRouteFound.path,
          name: AppRoutes.noRouteFound.routeName,
          builder: (BuildContext _, GoRouterState __) =>
              const PageNotFoundScreen(),
        );
    }
  }
}
