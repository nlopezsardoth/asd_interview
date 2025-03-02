import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_module/core/utils/extensions/context_extensions.dart';

class AsdLoader extends StatelessWidget {
  const AsdLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.halfTriangleDot(
        color: context.theme.primaryColor,
        size: 50,
      ),
    );
  }
}