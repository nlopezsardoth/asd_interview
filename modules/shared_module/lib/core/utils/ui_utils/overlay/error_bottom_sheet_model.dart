import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_module/presentation/widgets/errors/error_bottom_sheet.dart';


mixin ErrorBottomSheetStatusMixin {
  final ErrorBottomSheetCubit errorBottomSheetStatus = ErrorBottomSheetCubit();
}

class ErrorBottomSheetCubit extends Cubit<BottomSheetErrorType?> {
  ErrorBottomSheetCubit() : super(null);

  void postSomethingWentWrongError() {
    post(BottomSheetErrorType(ErrorType.somethingWentWrong));
  }

  void post(BottomSheetErrorType message) {
    emit(message);
  }

  void clearError() {
    emit(null);
  }

  @visibleForTesting
  void setValue(BottomSheetErrorType value) {
    emit(value);
  }

  @override
  String toString() => 'ErrorBottomSheetCubit(state: $state)';

}

class BottomSheetErrorType {
  final ErrorType type;
  final VoidCallback? callback;
  final VoidCallback? closeCallback;

  BottomSheetErrorType(this.type, [this.callback, this.closeCallback]);
}
