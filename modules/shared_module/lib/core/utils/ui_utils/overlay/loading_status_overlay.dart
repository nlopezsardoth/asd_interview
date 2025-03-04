import 'package:flutter/material.dart';
import 'package:shared_module/core/utils/ui_utils/overlay/error_bottom_sheet_model.dart';
import 'package:shared_module/core/utils/ui_utils/overlay/error_bottom_sheet_overlay.dart';
import 'package:shared_module/core/utils/ui_utils/overlay/loading_overlay.dart';
import 'package:shared_module/core/utils/ui_utils/overlay/loading_status_model.dart';
class LoadingStatusOverlay extends StatelessWidget {
  final LoadingStatusCubit loadingStatusCubit;
  final ErrorBottomSheetCubit? errorBottomSheetStatus;
  final bool canFetchContent;
  final Widget child;

  const LoadingStatusOverlay({
    super.key,
    required this.loadingStatusCubit,
    this.errorBottomSheetStatus,
    this.canFetchContent = true,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final loadingOverLay = LoadingOverlay(
      loadingStatusCubit: loadingStatusCubit,
      child: child,
    );
    if (errorBottomSheetStatus != null) {
      return ErrorBottomSheetOverlay(
        errorBottomSheetStatus: errorBottomSheetStatus!,
        child: loadingOverLay,
      );
    }
    return loadingOverLay;
  }
}
