import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tractian/core/infra/http/dio_http_service_imp.dart';
import 'package:tractian/core/infra/http/http_service.dart';
import 'package:tractian/core/utils/api_utils.dart';
import 'package:tractian/features/assets/data/datasources/assets_datasource.dart';
import 'package:tractian/features/assets/data/datasources/remote/assets_datasource_imp.dart';
import 'package:tractian/features/assets/data/repositories/assets_repository_imp.dart';
import 'package:tractian/features/assets/domain/repositories/assets_repository.dart';
import 'package:tractian/features/assets/domain/usecases/assets_usecase.dart';
import 'package:tractian/features/assets/domain/usecases/assets_usecase_imp.dart';
import 'package:tractian/features/assets/presentation/controllers/assets_controller.dart';
import 'package:tractian/features/menu/data/datasources/companies_datasource.dart';
import 'package:tractian/features/menu/data/datasources/companies_datasource_imp.dart';
import 'package:tractian/features/menu/data/repositories/companies_repository_imp.dart';
import 'package:tractian/features/menu/domain/repositories/companies_repository.dart';
import 'package:tractian/features/menu/domain/usecases/companies_usecase.dart';
import 'package:tractian/features/menu/domain/usecases/companies_usecase_imp.dart';
import 'package:tractian/features/menu/presentation/controllers/menu_controller.dart';

class Injection {
  static void init() {
    GetIt getIt = GetIt.instance;

    // core
    getIt.registerLazySingleton<Dio>(() => Dio(BaseOptions(baseUrl: API.baseUrl)));
    getIt.registerLazySingleton<HttpService>(() => DioHttpServiceImp(getIt()));

    // menu
    getIt.registerLazySingleton<CompaniesDataSource>(() => CompaniesDatasourceImp(getIt()));
    getIt.registerLazySingleton<CompaniesRepository>(() => CompaniesRepositoryImp(getIt()));
    getIt.registerLazySingleton<CompaniesUseCase>(() => CompaniesUseCaseImp(getIt()));
    getIt.registerLazySingleton<AppMenuController>(() => AppMenuController(getIt()));

    // assets
    getIt.registerLazySingleton<AssetsDataSource>(() => AssetsDatasourceImp(getIt()));
    getIt.registerLazySingleton<AssetsRepository>(() => AssetsRepositoryImp(getIt()));
    getIt.registerLazySingleton<AssetsUseCase>(() => AssetsUseCaseImp(getIt()));
    getIt.registerFactory<AssetsController>(() => AssetsController(getIt()));
  }
}
