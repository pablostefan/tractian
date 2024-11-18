import 'package:tractian/core/error/base_failure.dart';
import 'package:tractian/core/infra/local_storage/local_storage_service.dart';
import 'package:tractian/features/menu/data/datasources/local/companies_datasource_decorator.dart';

class CompaniesLocalDataSourceImp extends CompaniesDataSourceDecorator {
  final LocalStorageService _localStorageService;

  CompaniesLocalDataSourceImp(super.companiesDataSource, this._localStorageService);

  static const String _companiesKey = "companies";

  @override
  Future<List<dynamic>> getCompanies() async {
    try {
      final assetsResponse = await super.getCompanies();
      await _localStorageService.putData(_companiesKey, assetsResponse);
      return assetsResponse;
    } on NetworkFailure {
      return await _getInCache(_companiesKey);
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
