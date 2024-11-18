import 'package:tractian/features/assets/data/datasources/assets_datasource.dart';

class AssetsDataSourceDecorator implements AssetsDataSource {
  final AssetsDataSource assetsDataSource;

  AssetsDataSourceDecorator(this.assetsDataSource);

  @override
  Future<List<dynamic>> getAssets(String companyId) {
    return assetsDataSource.getAssets(companyId);
  }

  @override
  Future<List<dynamic>> getLocations(String companyId) {
    return assetsDataSource.getLocations(companyId);
  }
}
