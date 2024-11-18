abstract class LocalStorageService {
  Future<dynamic> getData(String key);

  Future<bool> putData(String key, dynamic value);
}
