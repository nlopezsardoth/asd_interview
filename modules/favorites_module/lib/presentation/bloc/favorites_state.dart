part of 'favorites_bloc.dart';

enum FavoriteStatus { initial, loading, success, failure }

class FavoritesState extends Equatable {
  final FavoriteStatus status;
  final List<Movie>? favorites;
  final bool? isFavorite;

  const FavoritesState({
    this.status = FavoriteStatus.initial,
    this.favorites,
    this.isFavorite,
  });

  FavoritesState copyWith({
    FavoriteStatus? status,
    List<Movie>? favorites,
    bool? isFavorite,
  }) {
    return FavoritesState(
      status: status ?? this.status,
      favorites: favorites ?? this.favorites,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [status, favorites, isFavorite];
}
