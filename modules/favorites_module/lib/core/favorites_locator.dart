import 'package:favorites_module/data/datasources/hive_datasource.dart';
import 'package:favorites_module/data/datasources/hive_datasource_impl.dart';
import 'package:favorites_module/data/repositories/favorites_repository_impl.dart';
import 'package:favorites_module/domain/repositories/favorites_repository.dart';
import 'package:favorites_module/domain/usecases/get_favorites_usecase.dart';
import 'package:favorites_module/domain/usecases/is_movie_favorite_usecase.dart';
import 'package:favorites_module/domain/usecases/toggle_favorite_usecase.dart';
import 'package:favorites_module/presentation/bloc/favorites_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

final favoritesLocator = GetIt.instance;

Future<void> initFavoritesLocator() async {
  final favoritesBox = await Hive.openBox(HiveDatasourceImpl.boxName);
  await _initFavoritesDependencies(favoritesBox);
}

Future<void> _initFavoritesDependencies(Box favoritesBox) async {
  favoritesLocator
    ..registerLazySingleton<HiveDatasource>(
      () => HiveDatasourceImpl(box: favoritesBox),
    )
    ..registerLazySingleton<FavoritesRepository>(
      () => FavoritesRepositoryImpl(
        datasource: favoritesLocator<HiveDatasource>(),
      ),
    )
    ..registerLazySingleton<GetFavoritesUseCase>(
      () => GetFavoritesUseCase(favoritesLocator<FavoritesRepository>()),
    )
    ..registerLazySingleton<IsMovieFavoriteUseCase>(
      () => IsMovieFavoriteUseCase(favoritesLocator<FavoritesRepository>()),
    )
    ..registerLazySingleton<ToggleFavoriteUseCase>(
      () => ToggleFavoriteUseCase(favoritesLocator<FavoritesRepository>()),
    )
    ..registerLazySingleton<FavoritesBloc>(
      () => FavoritesBloc(
        getFavoritesUseCase: favoritesLocator<GetFavoritesUseCase>(),
        toggleFavoriteUseCase: favoritesLocator<ToggleFavoriteUseCase>(),
        isMovieFavoriteUseCase: favoritesLocator<IsMovieFavoriteUseCase>(),
      ),
    );
}
