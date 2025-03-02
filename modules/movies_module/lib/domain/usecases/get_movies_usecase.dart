import 'package:movies_module/domain/entities/movie.dart';
import 'package:movies_module/domain/repositories/movie_repository.dart';
import 'package:shared_module/domain/use_cases/generic_use_cases.dart';
import 'package:shared_module/core/utils/typedefs.dart';


class GetMoviesUseCase extends FutureUseCase<List<Movie>, (ListType,int)> {
  final MovieRepository repository;

  GetMoviesUseCase(this.repository);

  @override
  ResultFuture<List<Movie>> call((ListType, int) input) async {
    return repository.getMovies(input.$1, input.$2);
  }
}