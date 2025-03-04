
import 'package:movies_module/domain/entities/movie.dart';
import 'package:movies_module/domain/repositories/movie_repository.dart';
import 'package:shared_module/core/utils/typedefs.dart';
import 'package:shared_module/domain/use_cases/generic_use_cases.dart';

class GetMovieDetailsUseCase extends FutureUseCase<Movie, int> {
  final MovieRepository repository;

  GetMovieDetailsUseCase(this.repository);

  @override
  ResultFuture<Movie> call(int movieId) async {
    return repository.getMovieDetails(movieId);
  }
}