part of 'favorites_bloc.dart';

abstract class FavoritesEvent {}

class LoadFavorites extends FavoritesEvent {}

class ToggleFavorite extends FavoritesEvent {
  final Movie movie;
  ToggleFavorite(this.movie);
}

class CheckIfFavorite extends FavoritesEvent {
  final int movieId;
  CheckIfFavorite(this.movieId);
}
