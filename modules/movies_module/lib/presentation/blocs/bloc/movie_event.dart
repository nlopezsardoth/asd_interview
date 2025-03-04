part of 'movie_bloc.dart';


abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

class LoadMovies extends MovieEvent {}

class SearchMovies extends MovieEvent {
  final String query;

  const SearchMovies(this.query);

  @override
  List<Object> get props => [query];
}

class GetMovieDetails extends MovieEvent {
  final int movieId;

  const GetMovieDetails(this.movieId);

  @override
  List<Object> get props => [movieId];
}

class ShowError extends MovieEvent {
  final String message;

  const ShowError(this.message);

  @override
  List<Object> get props => [message];
}

class SetSuccess extends MovieEvent {}
class SetFailure extends MovieEvent {}