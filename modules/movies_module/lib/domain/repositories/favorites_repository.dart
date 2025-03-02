import 'package:shared_module/core/utils/typedefs.dart';
import '../entities/movie.dart';

abstract class FavoritesRepository {
  ResultFuture<void> toggleFavorite(Movie movie);
  ResultFuture<bool> isMovieFavorite(int movieId);
  ResultFuture<List<Movie>> getFavorites();
}
