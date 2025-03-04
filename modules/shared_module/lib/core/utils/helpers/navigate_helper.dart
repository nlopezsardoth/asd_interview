import 'package:favorites_module/presentation/bloc/favorites_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_module/presentation/blocs/bloc/movie_bloc.dart';
import 'package:router_module/config/router_locator.dart';
import 'package:router_module/router/asd_router.dart';
import 'package:router_module/router/routes/movies_router.dart';

void navigateToMovieScreen(BuildContext context, int movieId) {
    context.read<MovieBloc>().add(GetMovieDetails(movieId));
    context.read<FavoritesBloc>().add(CheckIfFavorite(movieId));
    routerLocator<AsdRouter>().push(
      movieRoute.replaceFirst(":movieId",movieId.toString()),
    );
  }