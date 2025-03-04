import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_module/presentation/blocs/bloc/movie_bloc.dart';
import 'package:movies_module/presentation/views/movie_view.dart';
import 'package:shared_module/presentation/widgets/asd_loader.dart';
import 'package:shared_module/presentation/widgets/custom_sliver_appbar.dart';

@RoutePage()
class MovieScreen extends StatelessWidget {
  const MovieScreen({super.key, @PathParam('movieId') required this.movieId});

  final int movieId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieBloc()..add(GetMovieDetails(movieId)),
      child: BlocBuilder<MovieBloc, MovieState>(
        buildWhen: (context, state) {
          return state.movieDetail != null;
        },
        builder: (context, state) {
          if (state.movieDetail == null) {
            return const Scaffold(body: AsdLoader());
          }
          return Scaffold(
            body: CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: [
                CustomSliverAppBar(movie: state.movieDetail!),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => MovieView(movie: state.movieDetail!),
                    childCount: 1,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
