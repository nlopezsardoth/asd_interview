import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_module/domain/entities/movie.dart';
import 'package:movies_module/presentation/blocs/bloc/movie_bloc.dart';
import 'package:movies_module/presentation/delegates/search_movie_delegate.dart';
import 'package:router_module/config/router_locator.dart';
import 'package:router_module/router/asd_router.dart';
import 'package:router_module/router/routes/movies_router.dart';
import 'package:shared_module/core/utils/extensions/context_extensions.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colorScheme;
    final titleStyle = context.theme.textTheme.titleMedium;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(Icons.movie_outlined, color: colors.primary),
              const SizedBox(width: 5),
              Text(context.l10nShared.appbar_title, style: titleStyle),

              const Spacer(),

              IconButton(
                onPressed: () {
                  showSearch<Movie?>(
                    context: context,
                    delegate: SearchMovieDelegate(
                      fieldLabel: context.l10nMovies.search_movies_label,
                      searchFunction: (String query) => context.read<MovieBloc>().add(SearchMovies(query))
                    ),
                  ).then((movie) {
                    if (movie == null) return;

                    routerLocator<AsdRouter>().push(
                      movieRoute.replaceFirst(":movieId", movie.id.toString()),
                    );
                  });
                },
                icon: const Icon(Icons.search),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
