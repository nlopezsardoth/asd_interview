import 'package:auto_route/auto_route.dart';
import 'package:movies_module/router/movies_router.gm.dart';

const String moviesRoute = '/movies';

final moviesRoutes = [
  AutoRoute(
    path: moviesRoute,
    page: MoviesRoute.page,
  ),
];