import '../repositories/favorites_repository.dart';
import 'package:shared_module/domain/use_cases/generic_use_cases.dart';
import 'package:shared_module/core/utils/typedefs.dart';

class IsMovieFavoriteUseCase extends FutureUseCase<bool, int> {
  final FavoritesRepository repository;

  IsMovieFavoriteUseCase(this.repository);

  @override
  ResultFuture<bool> call(int movieId) async {
    return repository.isMovieFavorite(movieId);
  }
}
