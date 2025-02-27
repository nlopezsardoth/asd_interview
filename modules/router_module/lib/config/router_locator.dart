import 'package:get_it/get_it.dart';
import 'package:router_module/router/asd_router.dart';
import 'package:router_module/router/asd_router_impl.dart';

final routerLocator = GetIt.instance;

Future<void> initRouterLocator() async {
  await _initRouterDependencies();
}

Future<void> _initRouterDependencies() async {
  routerLocator.registerLazySingleton<AsdRouter>(() => AsdRouterImpl());
}
