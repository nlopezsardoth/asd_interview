import 'package:get_it/get_it.dart';
import 'package:movies_module/data/datasources/moviedb_datasource.dart';
import 'package:movies_module/data/datasources/moviedb_datasource_impl.dart';
import 'package:movies_module/data/repositories/movie_repository_impl.dart';
import 'package:movies_module/domain/repositories/movie_repository.dart';
import 'package:movies_module/domain/usecases/usecases.dart';
import 'package:movies_module/presentation/blocs/bloc/movie_bloc.dart';
import 'package:movies_module/presentation/cubits/movie_list_cubits.dart';

final moviesLocator = GetIt.instance;

Future<void> initMoviesLocator() async {
  await _initMoviesDependencies();
}

Future<void> _initMoviesDependencies() async {
  moviesLocator
    ..registerLazySingleton<MoviedbDatasource>(() => MoviedbDatasourceImpl())
    ..registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImpl(datasource: moviesLocator<MoviedbDatasource>()),
    )
    ..registerLazySingleton<GetMovieDetailsUseCase>(
      () => GetMovieDetailsUseCase(moviesLocator<MovieRepository>()),
    )
    ..registerLazySingleton<GetMoviesUseCase>(
      () => GetMoviesUseCase(moviesLocator<MovieRepository>()),
    )
    ..registerLazySingleton<SearchMoviesUseCase>(
      () => SearchMoviesUseCase(moviesLocator<MovieRepository>()),
    )
    ..registerLazySingleton<NowPlayingCubit>(
      () =>
          NowPlayingCubit(getMoviesUseCase: moviesLocator<GetMoviesUseCase>()),
    )
    ..registerLazySingleton<PopularCubit>(
      () => PopularCubit(getMoviesUseCase: moviesLocator<GetMoviesUseCase>()),
    )
    ..registerLazySingleton<TopRatedCubit>(
      () => TopRatedCubit(getMoviesUseCase: moviesLocator<GetMoviesUseCase>()),
    )
    ..registerLazySingleton<UpcomingCubit>(
      () => UpcomingCubit(getMoviesUseCase: moviesLocator<GetMoviesUseCase>()),
    )
    ..registerLazySingleton<MovieBloc>(
      () => MovieBloc(
        getMovieDetailsUsecase: moviesLocator<GetMovieDetailsUseCase>(),
        searchMoviesUseCase: moviesLocator<SearchMoviesUseCase>(),
        nowPlayingCubit: moviesLocator<NowPlayingCubit>(),
        popularCubit: moviesLocator<PopularCubit>(),
        topRatedCubit: moviesLocator<TopRatedCubit>(),
        upcomingCubit: moviesLocator<UpcomingCubit>(),
      ),
    );
}
