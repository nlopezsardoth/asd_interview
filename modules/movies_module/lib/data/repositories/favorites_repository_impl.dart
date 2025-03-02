import 'package:dartz/dartz.dart';
import 'package:movies_module/data/datasources/hive_datasource.dart';
import 'package:movies_module/domain/entities/movie.dart';
import 'package:movies_module/domain/repositories/favorites_repository.dart';
import 'package:shared_module/core/utils/typedefs.dart';
import 'package:shared_module/data/errors/failures.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final HiveDatasource datasource;

  FavoritesRepositoryImpl({required this.datasource});

  @override
  ResultFuture<void> toggleFavorite(Movie movie) async {
    try {
      await datasource.toggleFavorite(movie);
      return const Right(null);
    } catch (e) {
      return Left(LocalStorageFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<bool> isMovieFavorite(int movieId) async {
    try {
      final isFavorite = await datasource.isMovieFavorite(movieId);
      return Right(isFavorite);
    } catch (e) {
      return Left(LocalStorageFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<List<Movie>> getFavorites() async {
    try {
      final favorites = await datasource.loadMovies();
      return Right(favorites);
    } catch (e) {
      return Left(LocalStorageFailure(message: e.toString()));
    }
  }
}
