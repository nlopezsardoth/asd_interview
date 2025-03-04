import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:favorites_module/domain/usecases/get_favorites_usecase.dart';
import 'package:favorites_module/domain/usecases/is_movie_favorite_usecase.dart';
import 'package:favorites_module/domain/usecases/toggle_favorite_usecase.dart';
import 'package:movies_module/domain/entities/movie.dart';
import 'package:shared_module/core/utils/ui_utils/overlay/error_bottom_sheet_model.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState>
    with ErrorBottomSheetStatusMixin {
  final GetFavoritesUseCase getFavoritesUseCase;
  final ToggleFavoriteUseCase toggleFavoriteUseCase;
  final IsMovieFavoriteUseCase isMovieFavoriteUseCase;

  FavoritesBloc({
    required this.getFavoritesUseCase,
    required this.toggleFavoriteUseCase,
    required this.isMovieFavoriteUseCase,
  }) : super(FavoritesState()) {
    on<LoadFavorites>(_onLoadFavorites);
    on<ToggleFavorite>(_onToggleFavorite);
    on<CheckIfFavorite>(_onCheckIfFavorite);
  }

  Future<void> _onLoadFavorites(
    LoadFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(state.copyWith(status: FavoriteStatus.loading));
    final result = await getFavoritesUseCase.call(null);
    result.fold(
      (failure) {
        errorBottomSheetStatus.postSomethingWentWrongError();
        emit(state.copyWith(status: FavoriteStatus.failure));
      },
      (favorites) => emit(
        state.copyWith(favorites: favorites, status: FavoriteStatus.success),
      ),
    );
  }

  Future<void> _onToggleFavorite(
    ToggleFavorite event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(state.copyWith(status: FavoriteStatus.loading));
    final result = await toggleFavoriteUseCase.call(event.movie);
    result.fold(
      (failure) {
        errorBottomSheetStatus.postSomethingWentWrongError();
        emit(state.copyWith(status: FavoriteStatus.failure));
      },
      (success) {
        emit(state.copyWith(status: FavoriteStatus.success, isFavorite: !state.isFavorite!));
        add(LoadFavorites());
      },
    );
  }

  Future<void> _onCheckIfFavorite(
    CheckIfFavorite event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(state.copyWith(status: FavoriteStatus.loading, isFavorite: null));
    final result = await isMovieFavoriteUseCase.call(event.movieId);
    result.fold(
      (failure) {
        errorBottomSheetStatus.postSomethingWentWrongError();
        emit(state.copyWith(status: FavoriteStatus.failure));
      },
      (isFavorite) => emit(
        state.copyWith(isFavorite: isFavorite, status: FavoriteStatus.success),
      ),
    );
  }
}
