abstract class AssetsDataSource {
  Future<List<Map<String, dynamic>>> getAssets(String companyId);

  Future<List<Map<String, dynamic>>> getLocations(String companyId);
}
