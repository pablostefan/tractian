import 'package:tractian/features/menu/data/datasources/companies_datasource.dart';

class CompaniesDataSourceDecorator implements CompaniesDataSource {
  final CompaniesDataSource companiesDataSource;

  CompaniesDataSourceDecorator(this.companiesDataSource);

  @override
  Future<List<dynamic>> getCompanies() => companiesDataSource.getCompanies();
}
