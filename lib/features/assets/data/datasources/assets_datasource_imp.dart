import 'package:tractian/core/error/base_failure.dart';
import 'package:tractian/core/infra/http/http_service.dart';
import 'package:tractian/features/assets/data/datasources/assets_datasource.dart';

class AssetsDatasourceImp implements AssetsDataSource {
  final HttpService _httpService;

  AssetsDatasourceImp(this._httpService);

  @override
  Future<List<dynamic>> getAssets(String companyId) async {
    try {
      final response = await _httpService.get("/companies/$companyId/assets");
      return response.data;
    } catch (e, s) {
      throw NetworkFailure(message: "Falha ao buscar os ativos", stackTrace: s);
    }
  }

  @override
  Future<List<dynamic>> getLocations(String companyId) async {
    try {
      final response = await _httpService.get("/companies/$companyId/locations");
      return response.data;
    } catch (e, s) {
      throw NetworkFailure(message: "Falha ao buscar os ativos", stackTrace: s);
    }
  }
}
