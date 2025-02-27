import 'package:flutter/material.dart';
import 'package:router_module/router.dart';
import 'package:shared_module/presentation/widgets/asd_loader.dart';

@RoutePage()
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: AsdLoader());
  }
}
