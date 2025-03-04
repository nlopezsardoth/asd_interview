import 'package:bloc/bloc.dart';

enum LoadingStatus { initialLoading, refreshing, ready }

mixin LoadingStatusMixin {
  final LoadingStatusCubit loadingStatus = LoadingStatusCubit();
}

class LoadingStatusCubit extends Cubit<LoadingStatus> {
  bool _isInitialized = false;
  int _count = 0;
  int _startTime = DateTime.now().millisecondsSinceEpoch;
  int _endTime = DateTime.now().millisecondsSinceEpoch;

  LoadingStatusCubit({bool isInitialized = false}) : super(LoadingStatus.initialLoading) {
    _isInitialized = isInitialized;
    if (_isInitialized) {
      emit(LoadingStatus.ready);
    }
  }

  /// Calculates the total loading duration
  int get loadingTime => _endTime - _startTime;

  /// Marks loading as started
  void begin() {
    _count++;
    if (_count == 1 && _isInitialized) {
      _startTime = DateTime.now().millisecondsSinceEpoch;
      emit(LoadingStatus.refreshing);
    }
  }

  /// Marks loading as finished
  void end() {
    if (_count > 0) {
      _count--;
      if (_count == 0 && _isInitialized) {
        _endTime = DateTime.now().millisecondsSinceEpoch;
        emit(LoadingStatus.ready);
      }
    }
  }

  /// Initializes the loading state
  void setIsInitialized(bool isInitialized) {
    if (_isInitialized != isInitialized) {
      _isInitialized = isInitialized;
      if (_count == 0) {
        emit(_isInitialized ? LoadingStatus.ready : LoadingStatus.initialLoading);
      }
    }
  }

  /// Checks if something is still loading
  bool get isLoading => _count > 0;

  @override
  String toString() => 'LoadingStatusCubit(count: $_count, isInitialized: $_isInitialized)';
}