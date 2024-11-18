import 'package:tractian/core/error/base_failure.dart';
import 'package:tractian/core/infra/http/http_service.dart';
import 'package:tractian/features/assets/data/datasources/assets_datasource.dart';

class AssetsRemoteDatasourceImp implements AssetsDataSource {
  final HttpService _httpService;

  AssetsRemoteDatasourceImp(this._httpService);

  @override
  Future<List<dynamic>> getAssets(String companyId) async {
    try {
      final response = await _httpService.get("/companies/$companyId/assets");
      return response.data;
    } catch (e, s) {
      throw NetworkFailure(message: "Não foi possível buscar os Assets", stackTrace: s);
    }
  }

  @override
  Future<List<dynamic>> getLocations(String companyId) async {
    try {
      final response = await _httpService.get("/companies/$companyId/locations");
      return response.data;
    } catch (e, s) {
      throw NetworkFailure(message: "Não foi possível buscar as Localizações", stackTrace: s);
    }
  }
}
