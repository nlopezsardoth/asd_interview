import 'package:flutter/material.dart';
import 'package:shared_module/presentation/widgets/asd_loader.dart';
import 'package:shared_module/utils/ui_utils/overlay/loading_overlay.dart';

class LoadingOverlayContent extends StatelessWidget {
  final bool displayOverlay;
  final double overlayOpacity;

  const LoadingOverlayContent({
    super.key,
    this.displayOverlay = false,
    this.overlayOpacity = LoadingOverlay.overlayDefaultOpacity,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !displayOverlay,
      child: Center(
        child: displayOverlay ? AsdLoader() : null,
      ),
    );
  }
}