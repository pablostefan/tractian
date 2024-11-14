import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tractian/core/utils/api_utils.dart';

class Injection {
  static void init() {
    GetIt getIt = GetIt.instance;

    // core
    getIt.registerLazySingleton<Dio>(() => Dio(BaseOptions(baseUrl: API.baseUrl)));
  }
}
