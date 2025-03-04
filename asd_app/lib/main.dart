import 'package:favorites_module/core/favorites_locator.dart';
import 'package:favorites_module/core/l10n/favorites_localizations.dart';
import 'package:favorites_module/presentation/bloc/favorites_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:movies_module/core/l10n/movies_localizations.dart';
import 'package:movies_module/core/movies_locator.dart';
import 'package:movies_module/presentation/blocs/bloc/movie_bloc.dart';
import 'package:movies_module/presentation/cubits/movie_list_cubits.dart';
import 'package:router_module/config/router_locator.dart';
import 'package:router_module/router/app_router.dart';
import 'package:shared_module/core/environments/environment.dart';
import 'package:shared_module/core/l10n/shared_localizations.dart';
import 'package:shared_module/core/themes/theme.dart';
import 'package:shared_module/core/utils/ui_utils/overlay/loading_overlay_content.dart';

const _appName = 'Asd app';

Future<void> runCore(Flavor environment) async {
  WidgetsFlutterBinding.ensureInitialized();
  Environment.setUpEnv(environment);
  await _initLocalStorage();
  await _initLocators();

  runApp(_AsdApp());
}

Future<void> _initLocators() async {
  await initMoviesLocator();
  await initRouterLocator();
  await initFavoritesLocator();
}

Future<void> _initLocalStorage() async {
  await Hive.initFlutter();
}

class _AsdApp extends StatefulWidget {
  const _AsdApp();

  @override
  State<_AsdApp> createState() => _AsdAppState();
}

class _AsdAppState extends State<_AsdApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NowPlayingCubit>(
          create: (_) => moviesLocator<NowPlayingCubit>(),
        ),
        BlocProvider<PopularCubit>(
          create: (_) => moviesLocator<PopularCubit>(),
        ),
        BlocProvider<TopRatedCubit>(
          create: (_) => moviesLocator<TopRatedCubit>(),
        ),
        BlocProvider<UpcomingCubit>(
          create: (_) => moviesLocator<UpcomingCubit>(),
        ),
        BlocProvider<MovieBloc>(
          create: (_) => moviesLocator<MovieBloc>(),
        ),
        BlocProvider<FavoritesBloc>(
          create: (_) => favoritesLocator<FavoritesBloc>(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: _appName,
        theme: lightTheme.getTheme(),
        routerConfig: AppRouter().config(),
        localizationsDelegates: const [
          ...SharedLocalizations.localizationsDelegates,
          ...MoviesLocalizations.localizationsDelegates,
          ...FavoritesLocalizations.localizationsDelegates,
        ],
        supportedLocales: const [
          ...SharedLocalizations.supportedLocales,
          ...MoviesLocalizations.supportedLocales,
          ...FavoritesLocalizations.supportedLocales,
        ],
        builder:
            (_, child) => GlobalLoaderOverlay(
              overlayWidgetBuilder: (_) {
                return const LoadingOverlayContent(displayOverlay: true);
              },
              child: child!,
            ),
      ),
    );
  }
}
