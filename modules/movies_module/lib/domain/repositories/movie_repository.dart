
import 'package:shared_module/core/utils/typedefs.dart';

import '../entities/movie.dart';
enum ListType {nowPlaying, popular, upcoming, topRated}

abstract class MovieRepository {
  ResultFuture<List<Movie>> getMovies(ListType listType, int page);
  ResultFuture<List<Movie>> searchMovies(String query);
  ResultFuture<Movie> getMovieDetails(int id);
}
