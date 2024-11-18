import 'package:tractian/core/error/base_failure.dart';
import 'package:tractian/core/infra/http/http_service.dart';
import 'package:tractian/features/menu/data/datasources/companies_datasource.dart';

class CompaniesDatasourceImp implements CompaniesDataSource {
  final HttpService _httpService;

  CompaniesDatasourceImp(this._httpService);

  @override
  Future<List<dynamic>> getCompanies() async {
    try {
      final response = await _httpService.get("/companies");
      return response.data;
    } catch (e) {
      throw NetworkFailure(message: "Falha ao buscar as empresas");
    }
  }
}
