import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_module/data/repositories/movie_repository_impl.dart';
import 'package:movies_module/domain/entities/movie.dart';
import 'package:movies_module/domain/repositories/movie_repository.dart';
import 'package:movies_module/domain/usecases/get_movies_usecase.dart';

part 'movie_list_state.dart';

abstract class MovieListCubit extends Cubit<MovieListState> {
  final GetMoviesUseCase _getMoviesUseCase;
  final ListType listType;

  MovieListCubit({required this.listType, GetMoviesUseCase? getMoviesUseCase})
      : _getMoviesUseCase = getMoviesUseCase ?? GetMoviesUseCase(MovieRepositoryImpl()),
        super(MovieListInitial());

  Future<void> loadMovies({int page = 1}) async {
    emit(MovieListLoading());

    final result = await _getMoviesUseCase.call((listType, page));
    result.fold(
      (failure) => emit(MovieListFailed()),
      (movies) => emit(MovieListSuccess(movies, page)),
    );
  }
}
