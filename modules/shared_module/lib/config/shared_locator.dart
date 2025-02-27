
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:shared_module/config/environments/environment.dart';
import 'package:shared_module/data/networking/constants/dio_constants.dart';
import 'package:shared_module/data/networking/dio_builder.dart';
import 'package:shared_module/utils/loggers/asd_logger.dart';

final sharedLocator = GetIt.instance;

Future<void> initCommonsLocator(Flavor environment) async {
  await _initLoggerDependencies();
  await _initCommonsDependencies(environment);
}

Future<void> _initLoggerDependencies() async {
  sharedLocator.registerLazySingleton<Logger>(
    () => AsdLogger().getLogger(),
  );
}

Future<void> initNetworkServices() async {
  sharedLocator.registerLazySingleton<Dio>(() {
    final dio = DioBuilder.createDio(
      options: BaseOptions(
        headers: {
          DioConstants.requiresToken: true,
        },
      ),
    );

  

    return dio;
  });
}

Future<void> _initCommonsDependencies(Flavor environment) async {

}
