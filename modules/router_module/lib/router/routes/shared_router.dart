import 'package:auto_route/auto_route.dart';
import 'package:shared_module/router/shared_router.gm.dart';

const String splashRoute = '/';

final sharedRoutes = [
  AutoRoute(
    path: splashRoute,
    page: SplashRoute.page,
    initial: true,
  ),
];
