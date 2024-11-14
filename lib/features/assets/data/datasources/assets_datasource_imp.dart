import 'package:tractian/core/infra/http/http_service.dart';
import 'package:tractian/features/assets/data/datasources/assets_datasource.dart';

class AssetsDatasourceImp implements AssetsDataSource {
  final HttpService _httpService;

  AssetsDatasourceImp(this._httpService);

  @override
  Future<List<dynamic>> getAssets(String companyId) async {
    final response = await _httpService.get("/companies/$companyId/assets");
    return response.data;
  }

  @override
  Future<List<dynamic>> locations(String companyId) async {
    final response = await _httpService.get("/companies/$companyId/locations");
    return response.data;
  }
}
