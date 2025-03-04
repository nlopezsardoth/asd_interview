import 'package:auto_route/auto_route.dart';
import 'package:favorites_module/core/router/favorites_router.gm.dart';
import 'package:movies_module/core/router/movies_router.gm.dart';
import 'package:shared_module/core/router/shared_router.gm.dart';

const String splashRoute = '/';
const String homePage = "/home";
const String moviesRoute = 'movies';
const String favoritesRoute = 'favorites';

final sharedRoutes = [
  AutoRoute(path: splashRoute, page: SplashRoute.page, initial: true),
  AutoRoute(
    path: homePage,
    page: HomeRoute.page,
    children: [
      AutoRoute(path: moviesRoute, page: MoviesRoute.page),
      AutoRoute(path: favoritesRoute, page: FavoritesRoute.page),
    ],
  ),
];