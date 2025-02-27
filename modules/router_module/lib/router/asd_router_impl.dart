import 'package:flutter/material.dart';
import 'package:router_module/router/app_router.dart';
import 'package:router_module/router/asd_router.dart';
import 'package:router_module/router/routes/shared_router.dart';

class AsdRouterImpl implements AsdRouter {
  BuildContext get context => AppRouter().navigatorKey.currentContext!;

  @override
  Future<T?> push<T extends Object?>(String location) async {
    return AppRouter().pushNamed(location);
  }

  @override
  void go(String location) {
    AppRouter()
      ..popUntilRoot()
      ..replaceNamed(location);
  }

  @override
  void logOutNavigation() {
    go(splashRoute);
  }

  @override
  void pop<T extends Object?>([T? result]) {
    AppRouter().popForced();
  }
}
