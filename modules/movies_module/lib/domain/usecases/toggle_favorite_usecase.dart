
import 'package:movies_module/domain/entities/movie.dart';
import 'package:movies_module/domain/repositories/favorites_repository.dart';
import 'package:shared_module/core/utils/typedefs.dart';
import 'package:shared_module/domain/use_cases/generic_use_cases.dart';
class ToggleFavoriteUseCase extends FutureUseCase<void, Movie> {
  final FavoritesRepository repository;

  ToggleFavoriteUseCase(this.repository);

  @override
  ResultFuture<void> call(Movie movie) async {
    return repository.toggleFavorite(movie);
  }
}