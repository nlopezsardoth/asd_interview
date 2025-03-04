import 'package:auto_route/auto_route.dart';
import 'package:favorites_module/core/router/favorites_router.dart';
import 'package:movies_module/core/router/movies_router.dart';

import 'package:router_module/router/routes/movies_router.dart';
import 'package:router_module/router/routes/shared_router.dart';
import 'package:shared_module/core/router/shared_router.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route', modules: [
  FavoritesRouter,
  MoviesRouter,
  SharedRouter,
])
class AppRouter extends _$AppRouter {
  static final AppRouter _instance = AppRouter._internal();

  factory AppRouter() {
    return _instance;
  }

  AppRouter._internal();

  @override
  List<AutoRoute> get routes => [
    ...moviesRoutes,
    ...sharedRoutes,
  ];
}