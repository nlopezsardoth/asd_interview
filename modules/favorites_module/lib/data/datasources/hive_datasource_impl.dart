import 'package:favorites_module/data/models/local_movie_mapper.dart';
import 'package:hive/hive.dart';
import 'hive_datasource.dart';
import 'package:movies_module/domain/entities/movie.dart';
import 'package:shared_module/data/errors/exceptions.dart';

class HiveDatasourceImpl extends HiveDatasource {
   final Box _box;

  static const String boxName = 'favoritesBox';

  HiveDatasourceImpl({
    required Box box,
  }) : _box = box;

  @override
  Future<bool> isMovieFavorite(int movieId) async {
    try {

      return _box.containsKey(movieId);
    } catch (e) {
      throw LocalDatabaseException(message: e.toString());
    }
  }

  @override
  Future<void> toggleFavorite(Movie movie) async {
    try {


      if (await isMovieFavorite(movie.id)) {
        await _box.delete(movie.id);
      } else {
        await _box.put(movie.id, LocalMovieMapper.entityToMap(movie));
      }
    } catch (e) {
      throw LocalDatabaseException(message: e.toString());
    }
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, int offset = 0}) async {
    try {
      final movies = _box.values.map((e) => LocalMovieMapper.mapToEntity(e)).toList();

      return movies.skip(offset).take(limit).toList();
    } catch (e) {
      throw LocalDatabaseException(message: e.toString());
    }
  }
}
