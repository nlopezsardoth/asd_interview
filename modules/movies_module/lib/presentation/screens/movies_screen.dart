import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_module/core/l10n/movies_localizations.dart';
import 'package:movies_module/presentation/cubits/movie_list_cubit_definition.dart';
import 'package:movies_module/presentation/cubits/movie_list_cubits.dart';
import 'package:movies_module/presentation/widgets/movie_horizontal_listview.dart';
import 'package:movies_module/presentation/widgets/movies_slideshow.dart';
import 'package:shared_module/core/utils/extensions/context_extensions.dart';
import 'package:shared_module/presentation/widgets/custom_appbar.dart';

@RoutePage()
class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MoviesLocalizations l10n = context.l10nMovies;
    return CustomScrollView(
      slivers: [
       

        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return Column(
              children: [
                const CustomAppbar(),
                BlocBuilder<PopularCubit, MovieListState>(
                  buildWhen:
                      (previous, current) =>
                          previous is MovieListLoading &&
                          current is MovieListSuccess,
                  builder: (context, state) {
                    if (state is MovieListSuccess) {
                      return MoviesSlideshow(
                        movies: state.movies.sublist(0, 6),
                      );
                    }
                    return Container();
                  },
                ),

                BlocBuilder<NowPlayingCubit, MovieListState>(
                  buildWhen:
                      (previous, current) =>
                          previous is MovieListLoading &&
                          current is MovieListSuccess,
                  builder: (context, state) {
                    if (state is MovieListSuccess) {
                      return MovieHorizontalListview(
                        movies: state.movies,
                        title: l10n.now_playing_title,
                        subTitle: l10n.now_playing_subtitle,
                        loadNextPage:
                            context.read<NowPlayingCubit>().loadMovies,
                      );
                    }
                    return Container();
                  },
                ),

                BlocBuilder<UpcomingCubit, MovieListState>(
                  buildWhen:
                      (previous, current) =>
                          previous is MovieListLoading &&
                          current is MovieListSuccess,
                  builder: (context, state) {
                    if (state is MovieListSuccess) {
                      return MovieHorizontalListview(
                        movies: state.movies,
                        title: l10n.upcoming_title,
                        subTitle: l10n.upcoming_subtitle,
                        loadNextPage: context.read<UpcomingCubit>().loadMovies,
                      );
                    }
                    return Container();
                  },
                ),

                BlocBuilder<TopRatedCubit, MovieListState>(
                  buildWhen:
                      (previous, current) =>
                          previous is MovieListLoading &&
                          current is MovieListSuccess,
                  builder: (context, state) {
                    if (state is MovieListSuccess) {
                      return MovieHorizontalListview(
                        movies: state.movies,
                        title: l10n.top_rated_title,
                        subTitle: l10n.top_rated_subtitle,
                        loadNextPage: context.read<TopRatedCubit>().loadMovies,
                      );
                    }
                    return Container();
                  },
                ),
                const SizedBox(height: 10),
              ],
            );
          }, childCount: 1),
        ),
      ],
    );
  }
}
