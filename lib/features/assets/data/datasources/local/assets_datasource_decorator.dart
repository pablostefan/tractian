import 'package:tractian/features/assets/data/datasources/assets_datasource.dart';

class AssetsDataSourceDecorator implements AssetsDataSource {
  final AssetsDataSource _assetsDataSource;

  AssetsDataSourceDecorator(this._assetsDataSource);

  @override
  Future<List<Map<String, dynamic>>> getAssets(String companyId) {
    return _assetsDataSource.getAssets(companyId);
  }

  @override
  Future<List<Map<String, dynamic>>> getLocations(String companyId) {
    return _assetsDataSource.getLocations(companyId);
  }
}
