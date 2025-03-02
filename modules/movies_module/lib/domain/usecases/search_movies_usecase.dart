import 'package:movies_module/domain/entities/movie.dart';
import 'package:movies_module/domain/repositories/movie_repository.dart';
import 'package:shared_module/domain/use_cases/generic_use_cases.dart';
import 'package:shared_module/core/utils/typedefs.dart';

class SearchMoviesUseCase extends FutureUseCase<List<Movie>, String> {
  final MovieRepository repository;

  SearchMoviesUseCase(this.repository);

  @override
  ResultFuture<List<Movie>> call(String query) async {
    return repository.searchMovies(query);
  }
}
