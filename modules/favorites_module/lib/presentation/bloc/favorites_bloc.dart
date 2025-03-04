import 'package:bloc/bloc.dart';
import 'package:favorites_module/domain/usecases/get_favorites_usecase.dart';
import 'package:favorites_module/domain/usecases/is_movie_favorite_usecase.dart';
import 'package:favorites_module/domain/usecases/toggle_favorite_usecase.dart';
import 'package:movies_module/domain/entities/movie.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final GetFavoritesUseCase getFavoritesUseCase;
  final ToggleFavoriteUseCase toggleFavoriteUseCase;
  final IsMovieFavoriteUseCase isMovieFavoriteUseCase;

  FavoritesBloc({
    required this.getFavoritesUseCase,
    required this.toggleFavoriteUseCase,
    required this.isMovieFavoriteUseCase,
  }) : super(FavoritesInitial()) {
    on<LoadFavorites>(_onLoadFavorites);
    on<ToggleFavorite>(_onToggleFavorite);
    on<CheckIfFavorite>(_onCheckIfFavorite);
  }

  Future<void> _onLoadFavorites(
      LoadFavorites event, Emitter<FavoritesState> emit) async {
    emit(FavoritesLoading());
    final result = await getFavoritesUseCase(null);
    result.fold(
      (failure) => (),
      (favorites) => emit(FavoritesLoaded(favorites)),
    );
  }

  Future<void> _onToggleFavorite(
      ToggleFavorite event, Emitter<FavoritesState> emit) async {
    await toggleFavoriteUseCase(event.movie);
    add(LoadFavorites()); // Recargar la lista después de modificar favoritos
  }

  Future<void> _onCheckIfFavorite(
      CheckIfFavorite event, Emitter<FavoritesState> emit) async {
    final result = await isMovieFavoriteUseCase(event.movieId);
    result.fold(
      (failure) => (),
      (isFavorite) {
        if (state is FavoritesLoaded) {
          final updatedFavorites = (state as FavoritesLoaded).favorites;
          add(LoadFavorites()); // Se podría optimizar evitando recargar toda la lista
        }
      },
    );
  }

}