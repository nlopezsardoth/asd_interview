// Mocks generated by Mockito 5.4.5 from annotations
// in movies_module/test/data/mocks/datasource_mock_helper.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:movies_module/data/datasources/hive_datasource.dart' as _i6;
import 'package:movies_module/data/datasources/moviedb_datasource.dart' as _i3;
import 'package:movies_module/domain/entities/actor.dart' as _i5;
import 'package:movies_module/domain/entities/movie.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeMovie_0 extends _i1.SmartFake implements _i2.Movie {
  _FakeMovie_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [MoviedbDatasource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMoviedbDatasource extends _i1.Mock implements _i3.MoviedbDatasource {
  MockMoviedbDatasource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<List<_i2.Movie>> getPopular({int? page = 1}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getPopular,
          [],
          {#page: page},
        ),
        returnValue: _i4.Future<List<_i2.Movie>>.value(<_i2.Movie>[]),
      ) as _i4.Future<List<_i2.Movie>>);

  @override
  _i4.Future<List<_i2.Movie>> getNowPlaying({int? page = 1}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getNowPlaying,
          [],
          {#page: page},
        ),
        returnValue: _i4.Future<List<_i2.Movie>>.value(<_i2.Movie>[]),
      ) as _i4.Future<List<_i2.Movie>>);

  @override
  _i4.Future<List<_i2.Movie>> getTopRated({int? page = 1}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTopRated,
          [],
          {#page: page},
        ),
        returnValue: _i4.Future<List<_i2.Movie>>.value(<_i2.Movie>[]),
      ) as _i4.Future<List<_i2.Movie>>);

  @override
  _i4.Future<List<_i2.Movie>> getUpcoming({int? page = 1}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getUpcoming,
          [],
          {#page: page},
        ),
        returnValue: _i4.Future<List<_i2.Movie>>.value(<_i2.Movie>[]),
      ) as _i4.Future<List<_i2.Movie>>);

  @override
  _i4.Future<_i2.Movie> getMovieById(int? id) => (super.noSuchMethod(
        Invocation.method(
          #getMovieById,
          [id],
        ),
        returnValue: _i4.Future<_i2.Movie>.value(_FakeMovie_0(
          this,
          Invocation.method(
            #getMovieById,
            [id],
          ),
        )),
      ) as _i4.Future<_i2.Movie>);

  @override
  _i4.Future<List<_i2.Movie>> searchMovies(String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchMovies,
          [query],
        ),
        returnValue: _i4.Future<List<_i2.Movie>>.value(<_i2.Movie>[]),
      ) as _i4.Future<List<_i2.Movie>>);

  @override
  _i4.Future<List<_i5.Actor>> getActorsByMovie(int? movieId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getActorsByMovie,
          [movieId],
        ),
        returnValue: _i4.Future<List<_i5.Actor>>.value(<_i5.Actor>[]),
      ) as _i4.Future<List<_i5.Actor>>);
}

/// A class which mocks [HiveDatasource].
///
/// See the documentation for Mockito's code generation for more information.
class MockHiveDatasource extends _i1.Mock implements _i6.HiveDatasource {
  MockHiveDatasource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<bool> isMovieFavorite(int? movieId) => (super.noSuchMethod(
        Invocation.method(
          #isMovieFavorite,
          [movieId],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);

  @override
  _i4.Future<void> toggleFavorite(_i2.Movie? movie) => (super.noSuchMethod(
        Invocation.method(
          #toggleFavorite,
          [movie],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<List<_i2.Movie>> loadMovies({
    int? limit = 10,
    int? offset = 0,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #loadMovies,
          [],
          {
            #limit: limit,
            #offset: offset,
          },
        ),
        returnValue: _i4.Future<List<_i2.Movie>>.value(<_i2.Movie>[]),
      ) as _i4.Future<List<_i2.Movie>>);
}
