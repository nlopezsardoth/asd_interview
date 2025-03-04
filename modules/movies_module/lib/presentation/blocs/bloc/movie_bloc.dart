import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_module/data/repositories/movie_repository_impl.dart';
import 'package:movies_module/domain/entities/movie.dart';
import 'package:movies_module/domain/usecases/get_movie_detail_usecase.dart';
import 'package:movies_module/domain/usecases/search_movies_usecase.dart';
import 'package:movies_module/presentation/cubits/movie_list_cubit_definition.dart';
import 'package:movies_module/presentation/cubits/movie_list_cubits.dart';
import 'package:shared_module/core/utils/ui_utils/overlay/error_bottom_sheet_model.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState>
    with ErrorBottomSheetStatusMixin {
  final GetMovieDetailsUseCase _getMovieDetailsUsecase;
  final SearchMoviesUseCase _searchMoviesUseCase;

  final NowPlayingCubit _nowPlayingCubit;
  final PopularCubit _popularCubit;
  final TopRatedCubit _topRatedCubit;
  final UpcomingCubit _upcomingCubit;

  late StreamSubscription nowPlayingSubscription;
  late StreamSubscription popularSubscription;
  late StreamSubscription topRatedSubscription;
  late StreamSubscription upcomingSubscription;

  MovieBloc({
    GetMovieDetailsUseCase? getMovieDetailsUsecase,
    SearchMoviesUseCase? searchMoviesUseCase,
    NowPlayingCubit? nowPlayingCubit,
    PopularCubit? popularCubit,
    TopRatedCubit? topRatedCubit,
    UpcomingCubit? upcomingCubit,
  }) : _getMovieDetailsUsecase = getMovieDetailsUsecase ?? GetMovieDetailsUseCase(MovieRepositoryImpl()),
       _searchMoviesUseCase = searchMoviesUseCase ?? SearchMoviesUseCase(MovieRepositoryImpl()),
       _nowPlayingCubit = nowPlayingCubit ?? NowPlayingCubit(),
       _popularCubit = popularCubit ?? PopularCubit(),
       _topRatedCubit = topRatedCubit ?? TopRatedCubit(),
       _upcomingCubit = upcomingCubit ?? UpcomingCubit(),
       super(MovieState(moviesStatus: MovieStatus.initial)) {
    on<LoadMovies>(_onLoadMovies);
    on<SearchMovies>(_onSearchMovies);
    on<GetMovieDetails>(_onGetMovieDetails);
    on<ShowError>(_onShowError);
    on<SetSuccess>(_onSetSuccess);
    on<SetFailure>(_onSetFailure);
    _setupListeners();
  }

  void _setupListeners() {
    nowPlayingSubscription = _nowPlayingCubit.stream.listen((_) => _checkIfAllLoaded());
    popularSubscription = _popularCubit.stream.listen((_) => _checkIfAllLoaded());
    topRatedSubscription = _topRatedCubit.stream.listen((_) => _checkIfAllLoaded());
    upcomingSubscription = _upcomingCubit.stream.listen((_) => _checkIfAllLoaded());
  }

  void _checkIfAllLoaded() {
    final allLoaded = [
      _nowPlayingCubit.state,
      _popularCubit.state,
      _topRatedCubit.state,
      _upcomingCubit.state,
    ].every((state) => state is MovieListSuccess);

    final anyFailed = [
      _nowPlayingCubit.state,
      _popularCubit.state,
      _topRatedCubit.state,
      _upcomingCubit.state,
    ].any((state) => state is MovieListFailed);

    if (allLoaded) {
      add(SetSuccess());
    } else if (anyFailed) {
      add(SetFailure());
    }
  }


  Future<void> _onLoadMovies(
    LoadMovies event,
    Emitter<MovieState> emit,
  ) async {
    emit(state.copyWith(moviesStatus: MovieStatus.loading));
    _nowPlayingCubit.loadMovies();
    _popularCubit.loadMovies();
    _topRatedCubit.loadMovies();
    _upcomingCubit.loadMovies();
  }

  Future<void> _onSearchMovies(
    SearchMovies event,
    Emitter<MovieState> emit,
  ) async {
    emit(state.copyWith(searchStatus: MovieStatus.loading));
    final result = await _searchMoviesUseCase.call(event.query);
    result.fold((failure) {
      add(ShowError(failure.message));
      emit(state.copyWith(searchStatus: MovieStatus.failure));
    }, (movies) => emit(state.copyWith(searchStatus: MovieStatus.success, searchMovies: movies)));
  }

  Future<void> _onGetMovieDetails(
    GetMovieDetails event,
    Emitter<MovieState> emit,
  ) async {
    emit(state.copyWith(detailsStatus: MovieStatus.loading, movieDetail: null));
    final result = await _getMovieDetailsUsecase.call(event.movieId);
    result.fold((failure) {
      add(ShowError(failure.message));
      emit(state.copyWith(detailsStatus: MovieStatus.failure));
    }, (movie) => emit(state.copyWith(detailsStatus: MovieStatus.success, movieDetail: movie)));
  }

  void _onShowError(ShowError event, Emitter<MovieState> emit) {
    errorBottomSheetStatus.postSomethingWentWrongError();
  }
  void _onSetSuccess(SetSuccess event, Emitter<MovieState> emit) {
    emit(state.copyWith(moviesStatus: MovieStatus.success));
  }
  void _onSetFailure(SetFailure event, Emitter<MovieState> emit) {
    emit(state.copyWith(moviesStatus: MovieStatus.failure));
  }
}
