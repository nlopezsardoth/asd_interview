import 'package:movies_module/domain/entities/movie.dart';

abstract class HiveDatasource {
  Future<bool> isMovieFavorite(int movieId);
  Future<void> toggleFavorite(Movie movie);
  Future<List<Movie>> loadMovies({int limit = 10, int offset = 0});
}
