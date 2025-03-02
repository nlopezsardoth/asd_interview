import 'package:mockito/annotations.dart';
import 'package:movies_module/domain/repositories/actors_repository.dart';
import 'package:movies_module/domain/repositories/favorites_repository.dart';
import 'package:movies_module/domain/repositories/movie_repository.dart';

@GenerateMocks([ActorsRepository, MovieRepository, FavoritesRepository])
class RepositoriesMockHelper {}
