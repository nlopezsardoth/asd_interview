import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_module/utils/ui_utils/overlay/loading_overlay_content.dart';
import 'package:shared_module/utils/ui_utils/overlay/loading_status_model.dart';

class LoadingOverlay extends StatelessWidget {
  static const double overlayDefaultOpacity = 0.85;

  final LoadingStatusCubit loadingStatusCubit;
  final Widget child;

  const LoadingOverlay({
    super.key,
    required this.loadingStatusCubit,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoadingStatusCubit, LoadingStatus>(
      bloc: loadingStatusCubit,
      builder: (context, state) {
        return _buildContent(context, state, child);
      },
    );
  }

  Widget _buildContent(
    BuildContext context,
    LoadingStatus loadingStatus,
    Widget? child,
  ) {
    final double overlayOpacity;
    switch (loadingStatus) {
      case LoadingStatus.initialLoading:
        overlayOpacity = 1;
        break;
      case LoadingStatus.refreshing:
        overlayOpacity = overlayDefaultOpacity;
        break;
      default:
        overlayOpacity = 0;
    }

    final displayOverlay = overlayOpacity > 0;
    final loadingOverlay = LoadingOverlayContent(
      displayOverlay: displayOverlay,
      overlayOpacity: overlayOpacity,
    );

    return Stack(
      children: [
        child!,
        Positioned.fill(
          child: loadingOverlay,
        )
      ],
    );
  }
}
