import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum LoadingStatus { initialLoading, refreshing, ready }

class LoadingStatusModel extends ChangeNotifier
    implements ValueListenable<LoadingStatus> {
  bool _isInitialized = false;
  int _count = 0;
  int _startTime = DateTime.now().millisecondsSinceEpoch;
  int _endTime = DateTime.now().millisecondsSinceEpoch;

  int get loadingTime => _endTime - _startTime;

  LoadingStatusModel({bool isInitialized = false})
      : _isInitialized = isInitialized;

  void begin() {
    _count++;
    if (_count == 1 && _isInitialized) {
      _startTime = DateTime.now().millisecondsSinceEpoch;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }

  void end() {
    if (_count > 0) {
      _count--;
      if (_count == 0 && _isInitialized) {
        _endTime = DateTime.now().millisecondsSinceEpoch;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          notifyListeners();
        });
      }
    }
  }

  void setIsInitialized(bool isInitialized) {
    if (_isInitialized != isInitialized) {
      _isInitialized = isInitialized;
      if (_count == 0) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          notifyListeners();
        });
      }
    }
  }

  bool get isLoading {
    return _count > 0;
  }

  @override
  LoadingStatus get value {
    if (!_isInitialized) {
      return LoadingStatus.initialLoading;
    }
    return _count == 0 ? LoadingStatus.ready : LoadingStatus.refreshing;
  }

  @override
  String toString() => '${describeIdentity(this)}($_count)';
}
