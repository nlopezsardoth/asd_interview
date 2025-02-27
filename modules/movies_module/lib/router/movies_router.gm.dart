// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i2;
import 'package:movies_module/presentation/screens/movies_screen.dart' as _i1;

abstract class $MoviesRouter extends _i2.AutoRouterModule {
  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    MoviesRoute.name: (routeData) {
      return _i2.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.MoviesScreen(),
      );
    }
  };
}

/// generated route for
/// [_i1.MoviesScreen]
class MoviesRoute extends _i2.PageRouteInfo<void> {
  const MoviesRoute({List<_i2.PageRouteInfo>? children})
      : super(
          MoviesRoute.name,
          initialChildren: children,
        );

  static const String name = 'MoviesRoute';

  static const _i2.PageInfo<void> page = _i2.PageInfo<void>(name);
}
