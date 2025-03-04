import 'package:movies_module/domain/repositories/movie_repository.dart';
import 'package:movies_module/presentation/cubits/movie_list_cubit_definition.dart';

class NowPlayingCubit extends MovieListCubit {
  NowPlayingCubit({super.getMoviesUseCase})
      : super(listType: ListType.nowPlaying);
}

class PopularCubit extends MovieListCubit {
  PopularCubit({super.getMoviesUseCase})
      : super(listType: ListType.popular);
}

class TopRatedCubit extends MovieListCubit {
  TopRatedCubit({super.getMoviesUseCase})
      : super(listType: ListType.topRated);
}

class UpcomingCubit extends MovieListCubit {
  UpcomingCubit({super.getMoviesUseCase})
      : super(listType: ListType.upcoming);
}
