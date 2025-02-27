import 'package:dio/dio.dart';
import 'package:shared_module/data/networking/constants/timeout_constants.dart';

class DioBuilder {
  const DioBuilder._();

  static Dio createDio({
    BaseOptions? options,
    List<Interceptor>? interceptors,
  }) {
    return Dio(
      _buildOptions(options),
    )

      ..interceptors.addAll(interceptors ?? []);
  }

  static BaseOptions? _buildOptions(BaseOptions? options) {
    return BaseOptions(
      connectTimeout:
          options?.connectTimeout ?? timeoutConstants.connectTimeout,
      receiveTimeout:
          options?.receiveTimeout ?? timeoutConstants.receiveTimeout,
      sendTimeout: options?.sendTimeout ?? timeoutConstants.sendTimeout,
      baseUrl: options?.baseUrl ?? '',
      headers: options?.headers ?? {},
    );
  }
}
