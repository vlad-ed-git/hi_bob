import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hi_bob/core/routing/domain/top_level_routes.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

// GoRouter configuration
final GoRouter goRouter = GoRouter(
  initialLocation: AppRoutes.splashScreen.path,
  navigatorKey: _rootNavigatorKey,
  restorationScopeId: 'rid_12_11_1993',
  routes: AppRoutes.values.map((e) => e.getRoute()).toList(growable: false),
  onException: (BuildContext ctx, GoRouterState state, GoRouter router) {
    router.go(AppRoutes.noRouteFound.path, extra: state.uri.toString());
  },
);
