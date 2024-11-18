import 'package:tractian/core/error/base_failure.dart';
import 'package:tractian/core/infra/local_storage/local_storage_service.dart';
import 'package:tractian/features/assets/data/datasources/local/assets_datasource_decorator.dart';

class AssetsLocalDataSourceImp extends AssetsDataSourceDecorator {
  final LocalStorageService _localStorageService;

  AssetsLocalDataSourceImp(super.assetsDataSource, this._localStorageService);

  @override
  Future<List<dynamic>> getAssets(String companyId) async {
    final String cacheKey = companyId;
    try {
      final assetsResponse = await super.getAssets(companyId);
      await _localStorageService.putData(cacheKey, assetsResponse);
      return assetsResponse;
    } on NetworkFailure {
      return await _getInCache(cacheKey);
    } catch (e, s) {
      throw CacheDataFailure(message: "Não foi possível buscar os dados", stackTrace: s);
    }
  }

  @override
  Future<List<dynamic>> getLocations(String companyId) async {
    final String cacheKey = companyId;
    try {
      var assetsResponse = await super.getLocations(companyId);
      await _localStorageService.putData(cacheKey, assetsResponse);
      return assetsResponse;
    } on NetworkFailure {
      return await _getInCache(cacheKey);
    } catch (e, s) {
      throw CacheDataFailure(message: "Não foi possível buscar os dados", stackTrace: s);
    }
  }

  Future<dynamic> _getInCache(String key) async {
    try {
      var data = await _localStorageService.getData(key);
      return data;
    } catch (e, s) {
      throw CacheDataFailure(message: "Nenhum dado disponível.", stackTrace: s);
    }
  }
}
