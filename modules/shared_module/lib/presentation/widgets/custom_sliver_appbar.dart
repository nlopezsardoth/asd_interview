import 'package:animate_do/animate_do.dart';
import 'package:favorites_module/presentation/bloc/favorites_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_module/domain/entities/movie.dart';
import 'package:shared_module/presentation/widgets/custom_gradient.dart';

class CustomSliverAppBar extends StatelessWidget {
  final Movie movie;

  const CustomSliverAppBar({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        return SliverAppBar(
          backgroundColor: Colors.black,
          expandedHeight: size.height * 0.7,
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              onPressed: () async {
                context.read<FavoritesBloc>().add(ToggleFavorite(movie));

              },
              icon:
                  state.status == FavoriteStatus.loading || state.status == FavoriteStatus.initial
                      ? const CircularProgressIndicator(strokeWidth: 2)
                      : state.isFavorite ?? false
                      ? const Icon(Icons.favorite_rounded, color: Colors.red)
                      : const Icon(Icons.favorite_border),
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: const EdgeInsets.only(bottom: 0),
            title: CustomGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.7, 1.0],
              colors: [Colors.transparent, scaffoldBackgroundColor],
            ),
            background: Stack(
              children: [
                SizedBox.expand(
                  child: Image.network(
                    movie.posterPath,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress != null) return const SizedBox();
                      return FadeIn(child: child);
                    },
                  ),
                ),

                //* Favorite Gradient Background
                const CustomGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [0.0, 0.2],
                  colors: [Colors.black54, Colors.transparent],
                ),

                //* Back arrow background
                const CustomGradient(
                  begin: Alignment.topLeft,
                  stops: [0.0, 0.3],
                  colors: [Colors.black87, Colors.transparent],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
