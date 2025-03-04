import 'package:favorites_module/presentation/bloc/favorites_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_module/presentation/blocs/bloc/movie_bloc.dart';
import 'package:router_module/config/router_locator.dart';
import 'package:router_module/router.dart';
import 'package:router_module/router/asd_router.dart';
import 'package:shared_module/presentation/widgets/asd_loader.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Trigger movie loading
    context.read<MovieBloc>().add(LoadMovies());
    context.read<FavoritesBloc>().add(LoadFavorites());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MovieBloc, MovieState>(
      listenWhen:
          (previous, current) =>
              previous.moviesStatus == MovieStatus.loading &&
              current.moviesStatus == MovieStatus.success,
      listener: (context, state) {
        if (state.moviesStatus == MovieStatus.success) {
          routerLocator<AsdRouter>().push(homePage); // Navigate when done
        }
      },
      child: const Scaffold(
        body: Center(
          child: AsdLoader(), // Show loading spinner
        ),
      ),
    );
  }
}
