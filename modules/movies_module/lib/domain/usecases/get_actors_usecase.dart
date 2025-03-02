import 'package:movies_module/domain/entities/actor.dart';
import 'package:movies_module/domain/repositories/actors_repository.dart';
import 'package:shared_module/domain/use_cases/generic_use_cases.dart';
import 'package:shared_module/core/utils/typedefs.dart';

class GetActorsUseCase extends FutureUseCase<List<Actor>, int> {
  final ActorsRepository repository;

  GetActorsUseCase(this.repository);

  @override
  ResultFuture<List<Actor>> call(int movieId) async {
    return repository.getActorsByMovie(movieId);
  }
}