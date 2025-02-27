import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:router_module/config/router_locator.dart';
import 'package:router_module/router/app_router.dart';
import 'package:shared_module/config/environments/environment.dart';
import 'package:shared_module/l10n/shared_localizations.dart';
import 'package:shared_module/themes/theme.dart';
import 'package:shared_module/utils/ui_utils/overlay/loading_overlay_content.dart';

const _appName = 'Asd app';

Future<void> runCore(Flavor environment) async {
  WidgetsFlutterBinding.ensureInitialized();
  Environment.setUpEnv(environment);
  await _initLocators();

  runApp(_AsdApp());
}

Future<void> _initLocators() async {
  // await initSharedLocator();
  await initRouterLocator();
  // await initHomeLocator();
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
