// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;
import 'package:movies_module/presentation/screens/movie_screen.dart' as _i1;
import 'package:movies_module/presentation/screens/movies_screen.dart' as _i2;

abstract class $MoviesRouter extends _i3.AutoRouterModule {
  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    MovieRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<MovieRouteArgs>(
          orElse: () => MovieRouteArgs(movieId: pathParams.getInt('movieId')));
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.MovieScreen(
          key: args.key,
          movieId: args.movieId,
        ),
      );
    },
    MoviesRoute.name: (routeData) {
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.MoviesScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.MovieScreen]
class MovieRoute extends _i3.PageRouteInfo<MovieRouteArgs> {
  MovieRoute({
    _i4.Key? key,
    required int movieId,
    List<_i3.PageRouteInfo>? children,
  }) : super(
          MovieRoute.name,
          args: MovieRouteArgs(
            key: key,
            movieId: movieId,
          ),
          rawPathParams: {'movieId': movieId},
          initialChildren: children,
        );

  static const String name = 'MovieRoute';

  static const _i3.PageInfo<MovieRouteArgs> page =
      _i3.PageInfo<MovieRouteArgs>(name);
}

class MovieRouteArgs {
  const MovieRouteArgs({
    this.key,
    required this.movieId,
  });

  final _i4.Key? key;

  final int movieId;

  @override
  String toString() {
    return 'MovieRouteArgs{key: $key, movieId: $movieId}';
  }
}

/// generated route for
/// [_i2.MoviesScreen]
class MoviesRoute extends _i3.PageRouteInfo<void> {
  const MoviesRoute({List<_i3.PageRouteInfo>? children})
      : super(
          MoviesRoute.name,
          initialChildren: children,
        );

  static const String name = 'MoviesRoute';

  static const _i3.PageInfo<void> page = _i3.PageInfo<void>(name);
}
