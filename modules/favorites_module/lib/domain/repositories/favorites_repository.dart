import 'package:movies_module/domain/entities/movie.dart';
import 'package:shared_module/core/utils/typedefs.dart';

abstract class FavoritesRepository {
  ResultFuture<void> toggleFavorite(Movie movie);
  ResultFuture<bool> isMovieFavorite(int movieId);
  ResultFuture<List<Movie>> getFavorites();
}
