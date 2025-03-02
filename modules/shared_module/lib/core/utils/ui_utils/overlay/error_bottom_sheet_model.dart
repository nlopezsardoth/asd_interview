import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_module/presentation/widgets/errors/error_bottom_sheet.dart';

class ErrorBottomSheetModel extends ChangeNotifier
    implements ValueListenable<BottomSheetErrorType?> {
  BottomSheetErrorType? _bottomSheetErrorType;

  void postSomethingWentWrongError() {
    post(BottomSheetErrorType(ErrorType.somethingWentWrong));
  }

  void post(BottomSheetErrorType message) {
    _bottomSheetErrorType = message;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  @override
  BottomSheetErrorType? get value => _bottomSheetErrorType;

  @visibleForTesting
  void setValue(BottomSheetErrorType value) {
    _bottomSheetErrorType = value;
  }

  @override
  String toString() => '${describeIdentity(this)}($_bottomSheetErrorType)';
}

class BottomSheetErrorType {
  final ErrorType type;
  final VoidCallback? callback;
  final VoidCallback? closeCallback;

  BottomSheetErrorType(this.type, [this.callback, this.closeCallback]);
}
