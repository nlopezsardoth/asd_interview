import 'package:movies_module/domain/entities/movie.dart';
import '../repositories/favorites_repository.dart';
import 'package:shared_module/domain/use_cases/generic_use_cases.dart';
import 'package:shared_module/core/utils/typedefs.dart';

class GetFavoritesUseCase extends FutureUseCase<List<Movie>, void> {
  final FavoritesRepository repository;

  GetFavoritesUseCase(this.repository);

  @override
  ResultFuture<List<Movie>> call(void _) async {
    return repository.getFavorites();
  }
}