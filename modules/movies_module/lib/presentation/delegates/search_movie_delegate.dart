import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_module/domain/entities/movie.dart';
import 'package:movies_module/presentation/blocs/bloc/movie_bloc.dart';
import 'package:shared_module/core/utils/helpers/human_formats.dart';
import 'package:shared_module/presentation/widgets/custom_asset_image.dart';


class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final String fieldLabel;

  Timer? _debounceTimer;

  Function(String) searchFunction;

  SearchMovieDelegate({required this.fieldLabel, required this.searchFunction})
    : super(searchFieldLabel: fieldLabel);

  void _onQueryChanged(String query, BuildContext context) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      if (query.isEmpty) return;
      searchFunction.call(query);
    });
  }

  Widget buildResultsAndSuggestions() {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        if (state.searchStatus == MovieStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.searchStatus == MovieStatus.failure) {
          return const Center(child: Text("Error loading movies"));
        }

        final movies = state.searchMovies ?? [];
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder:
              (context, index) => _MovieItem(
                movie: movies[index],
                onMovieSelected: (context, movie) {
                  close(context, movie);
                },
              ),
        );
      },
    );
  }

  // @override
  // String get searchFieldLabel => 'Buscar película';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state.searchStatus == MovieStatus.loading) {
            return SpinPerfect(
              duration: const Duration(seconds: 20),
              spins: 10,
              infinite: true,
              child: IconButton(
                onPressed: () => query = '',
                icon: const Icon(Icons.refresh_rounded),
              ),
            );
          }

          return FadeIn(
            animate: query.isNotEmpty,
            child: IconButton(
              onPressed: () => query = '',
              icon: const Icon(Icons.clear),
            ),
          );
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildResultsAndSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query, context);
    return buildResultsAndSuggestions();
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function onMovieSelected;

  const _MovieItem({required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        onMovieSelected(context, movie);
      },
      child: FadeIn(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            children: [
              // Image
              SizedBox(
                width: size.width * 0.2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FadeInImage(
                    height: 130,
                    fit: BoxFit.cover,
                    image: NetworkImage(movie.posterPath),
                    placeholder: customAssetImage(),
                    imageErrorBuilder: (context, error, stackTrace) => Container(),
                  ),
                ),
              ),

              const SizedBox(width: 10),

              // Description
              SizedBox(
                width: size.width * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.title, style: textStyles.titleMedium),

                    (movie.overview.length > 100)
                        ? Text('${movie.overview.substring(0, 100)}...')
                        : Text(movie.overview),

                    Row(
                      children: [
                        Icon(
                          Icons.star_half_rounded,
                          color: Colors.yellow.shade800,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          HumanFormats.number(movie.voteAverage, 1),
                          style: textStyles.bodyMedium!.copyWith(
                            color: Colors.yellow.shade900,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
