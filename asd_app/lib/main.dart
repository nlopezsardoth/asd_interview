import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
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
  await _initLocators();
  await _initLocalStorage();

  runApp(_AsdApp());
}

Future<void> _initLocators() async {
  // await initSharedLocator();
  await initRouterLocator();
  // await initHomeLocator();
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
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: _appName,
      theme: lightTheme.getTheme(),
      routerConfig: AppRouter().config(),
      localizationsDelegates: const [
        ...SharedLocalizations.localizationsDelegates,
        // ...HomeLocalizations.localizationsDelegates,
      ],
      supportedLocales: const [
        ...SharedLocalizations.supportedLocales,
        // ...HomeLocalizations.supportedLocales
      ],
      builder:
          (_, child) => GlobalLoaderOverlay(
            overlayWidgetBuilder: (_) {
              return const LoadingOverlayContent(displayOverlay: true);
            },
            child: child!,
          ),
    );
  }
}
