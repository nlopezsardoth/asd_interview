import 'package:movies_module/domain/entities/actor.dart';
import 'package:movies_module/domain/entities/movie.dart';

abstract class MoviedbDatasource {
  Future<List<Movie>> getPopular({int page = 1});
  Future<List<Movie>> getNowPlaying({int page = 1});
  Future<List<Movie>> getTopRated({int page = 1});
  Future<List<Movie>> getUpcoming({int page = 1});
  Future<Movie> getMovieById( int id );
  Future<List<Movie>> searchMovies(String query);
  Future<List<Actor>> getActorsByMovie( int movieId );
}