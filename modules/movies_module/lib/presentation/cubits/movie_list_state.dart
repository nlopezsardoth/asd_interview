part of 'movie_list_cubit_definition.dart';

abstract class MovieListState extends Equatable {
  const MovieListState();

  @override
  List<Object> get props => [];
}

class MovieListInitial extends MovieListState {}

class MovieListLoading extends MovieListState {}

class MovieListSuccess extends MovieListState {
  final List<Movie> movies;
  final int page;

  const MovieListSuccess(this.movies, this.page);

  @override
  List<Object> get props => [movies, page];
}

class MovieListFailed extends MovieListState {}
