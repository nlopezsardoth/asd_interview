import 'package:dartz/dartz.dart';
import 'package:movies_module/data/datasources/moviedb_datasource.dart';
import 'package:movies_module/domain/entities/actor.dart';
import 'package:movies_module/domain/repositories/actors_repository.dart';
import 'package:shared_module/core/utils/typedefs.dart';
import 'package:shared_module/data/errors/failures.dart';

class ActorsRepositoryImpl implements ActorsRepository {
  final MoviedbDatasource datasource;

  ActorsRepositoryImpl({required this.datasource});

  @override
  ResultFuture<List<Actor>> getActorsByMovie(int movieId) async {
    try {
      final actors = await datasource.getActorsByMovie(movieId);
      return Right(actors);
    } on MoviesServerFailure catch (e) {
      return Left(e);
    }
  }
}
