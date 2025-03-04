part of 'movie_bloc.dart';

enum MovieStatus { initial, loading, success, failure }

class MovieState extends Equatable {
  final MovieStatus moviesStatus;
  final MovieStatus searchStatus;
  final MovieStatus detailsStatus;
  final List<Movie>? searchMovies;
  final String? searchQuery;
  final Movie? movieDetail;

  const MovieState({
    this.moviesStatus = MovieStatus.initial,
    this.searchStatus = MovieStatus.initial,
    this.detailsStatus = MovieStatus.initial,
    this.searchMovies,
    this.searchQuery,
    this.movieDetail,
  });

  MovieState copyWith({
    MovieStatus? moviesStatus,
    MovieStatus? searchStatus,
    MovieStatus? detailsStatus,
    List<Movie>? searchMovies,
    String? searchQuery,
    Movie? movieDetail,
    String? errorMessage,
  }) {
    return MovieState(
      moviesStatus: moviesStatus ?? this.moviesStatus,
      searchStatus: searchStatus ?? this.searchStatus,
      detailsStatus: detailsStatus ?? this.detailsStatus,
      searchMovies: searchMovies ?? this.searchMovies,
      searchQuery: searchQuery ?? this.searchQuery,
      movieDetail: movieDetail ?? this.movieDetail,
    );
  }

  @override
  List<Object?> get props => [moviesStatus, searchMovies, movieDetail];
}