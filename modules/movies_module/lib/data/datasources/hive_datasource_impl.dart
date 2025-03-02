import 'package:hive/hive.dart';
import 'package:movies_module/data/datasources/hive_datasource.dart';
import 'package:movies_module/data/mappers/movie_mapper.dart';
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
        await _box.put(movie.id, MovieMapper.entityToMap(movie));
      }
    } catch (e) {
      throw LocalDatabaseException(message: e.toString());
    }
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, int offset = 0}) async {
    try {
      final movies = _box.values.map((e) => MovieMapper.mapToEntity(e)).toList();

      return movies.skip(offset).take(limit).toList();
    } catch (e) {
      throw LocalDatabaseException(message: e.toString());
    }
  }
}
