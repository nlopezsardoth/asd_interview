import 'package:flutter/material.dart';
import 'package:shared_module/core/utils/ui_utils/overlay/error_bottom_sheet_model.dart';
import 'package:shared_module/presentation/widgets/errors/error_bottom_sheet.dart';

class ErrorBottomSheetOverlay extends StatelessWidget {
  final ErrorBottomSheetModel errorBottomSheetStatus;
  final Widget child;

  const ErrorBottomSheetOverlay({
    super.key,
    required this.errorBottomSheetStatus,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<BottomSheetErrorType?>(
      valueListenable: errorBottomSheetStatus,
      builder: _buildContent,
      child: child,
    );
  }

  Widget _buildContent(
    BuildContext context,
    BottomSheetErrorType? bottomSheetErrorType,
    Widget? child,
  ) {
    if (bottomSheetErrorType != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ErrorBottomSheet.showErrorModal(
          context,
          bottomSheetErrorType.type,
          bottomSheetErrorType.callback,
          bottomSheetErrorType.closeCallback,
        );
      });
    }

    return child!;
  }
}
