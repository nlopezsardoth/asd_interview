import 'package:favorites_module/presentation/bloc/favorites_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:router_module/router.dart';
import 'package:shared_module/core/utils/extensions/context_extensions.dart';
import 'package:shared_module/presentation/widgets/asd_loader.dart';
import 'package:shared_module/presentation/widgets/movie_masonry.dart';

@RoutePage()
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        if (state.status == FavoriteStatus.loading ||
            state.status == FavoriteStatus.loading) {
          return Scaffold(body: AsdLoader());
        }
        if (state.status == FavoriteStatus.success) {
          if (state.favorites == null || state.favorites!.isEmpty) {
            final colors = Theme.of(context).colorScheme;
            return _NoFavoritesWidget(colors: colors);
          } else {
            return Scaffold(body: MovieMasonry(movies: state.favorites ?? []));
          }
        } else {
          return Scaffold(
            body: Center(
              child: Text(context.l10nShared.something_went_wrong_title),
            ),
          );
        }
      },
    );
  }
}

class _NoFavoritesWidget extends StatelessWidget {
  const _NoFavoritesWidget({required this.colors});

  final ColorScheme colors;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colorScheme;
    final l10n = context.l10nFavorites;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.favorite_outline_sharp, size: 60, color: colors.primary),
          Text(
            l10n.no_favorites_title,
            style: TextStyle(fontSize: 30, color: colors.primary),
          ),
          Text(l10n.no_favorites_subtitle, style: TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}
