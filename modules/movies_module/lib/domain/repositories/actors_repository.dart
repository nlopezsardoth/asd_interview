
import 'package:movies_module/domain/entities/actor.dart';
import 'package:shared_module/core/utils/typedefs.dart';

abstract class ActorsRepository {

  ResultFuture<List<Actor>> getActorsByMovie(int movieId );

}