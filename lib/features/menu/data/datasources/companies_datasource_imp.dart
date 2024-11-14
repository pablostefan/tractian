import 'package:tractian/core/infra/http/http_service.dart';
import 'package:tractian/features/menu/data/datasources/companies_datasource.dart';

class CompaniesDatasourceImp implements CompaniesDataSource {
  final HttpService _httpService;

  CompaniesDatasourceImp(this._httpService);

  @override
  Future<List<dynamic>> getCompanies() async {
    final response = await _httpService.get("/companies");
    return response.data;
  }
}
