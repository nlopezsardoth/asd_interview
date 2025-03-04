import 'package:auto_route/auto_route.dart';
import 'package:movies_module/core/router/movies_router.gm.dart';


const String movieRoute = '/movie/:movieId';

final moviesRoutes = [
  AutoRoute(
    path: movieRoute,
    page: MovieRoute.page,
  ),
];