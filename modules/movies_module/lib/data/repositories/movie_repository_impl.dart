import 'package:dartz/dartz.dart';
import 'package:movies_module/data/datasources/moviedb_datasource.dart';
import 'package:movies_module/domain/entities/movie.dart';
import 'package:movies_module/domain/repositories/movie_repository.dart';
import 'package:shared_module/core/utils/typedefs.dart';
import 'package:shared_module/data/errors/failures.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MoviedbDatasource datasource;

  MovieRepositoryImpl({required this.datasource});

  @override
  ResultFuture<Movie> getMovieDetails(int id) async {
    try {
      final actors = await datasource.getMovieById(id);
      return Right(actors);
    } on MoviesServerFailure catch (e) {
      return Left(e);
    }
  }

  @override
  ResultFuture<List<Movie>> getMovies(ListType listType, int page) async {
    late List<Movie> movies;
    try {
      switch (listType) {
        case ListType.nowPlaying:
          movies = await datasource.getNowPlaying(page: page);
          break;
        case ListType.popular:
          movies = await datasource.getPopular(page: page);
          break;
        case ListType.topRated:
          movies = await datasource.getTopRated(page: page);
          break;
        case ListType.upcoming:
          movies = await datasource.getUpcoming(page: page);
          break;
      }
      return Right(movies);
    } on MoviesServerFailure catch (e) {
      return Left(e);
    }
  }
  
  @override
  ResultFuture<List<Movie>> searchMovies(String query) async {
    try {
      final movies = await datasource.searchMovies(query);
      return Right(movies);
    } on MoviesServerFailure catch (e) {
      return Left(e);
    }
  }
}
