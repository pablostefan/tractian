abstract class AssetsDataSource {
  Future<List<dynamic>> getAssets(String companyId);
  Future<List<dynamic>> locations(String companyId);
}
