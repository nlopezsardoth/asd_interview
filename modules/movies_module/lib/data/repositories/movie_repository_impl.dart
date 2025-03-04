import 'package:dartz/dartz.dart';
import 'package:movies_module/data/datasources/moviedb_datasource.dart';
import 'package:movies_module/data/datasources/moviedb_datasource_impl.dart';
import 'package:movies_module/domain/entities/movie.dart';
import 'package:movies_module/domain/repositories/movie_repository.dart';
import 'package:shared_module/core/utils/typedefs.dart';
import 'package:shared_module/data/errors/failures.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MoviedbDatasource _datasource;

  MovieRepositoryImpl({ MoviedbDatasource? datasource}): _datasource = datasource ?? MoviedbDatasourceImpl();

  @override
  ResultFuture<Movie> getMovieDetails(int id) async {
    try {
      final actors = await _datasource.getMovieById(id);
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
          movies = await _datasource.getNowPlaying(page: page);
          break;
        case ListType.popular:
          movies = await _datasource.getPopular(page: page);
          break;
        case ListType.topRated:
          movies = await _datasource.getTopRated(page: page);
          break;
        case ListType.upcoming:
          movies = await _datasource.getUpcoming(page: page);
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
      final movies = await _datasource.searchMovies(query);
      return Right(movies);
    } on MoviesServerFailure catch (e) {
      return Left(e);
    }
  }
}
