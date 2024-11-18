abstract class LocalStorageService {
  Future<dynamic> getData(String key);

  Future<String?> getString(String key);

  Future<bool> putData(String key, dynamic value);

  Future<bool> putString(String key, String value);
}
