extension ListExtension on List {
  Map<K, List<T>> groupBy<T, K>(K Function(T) getKey) {
    Map<K, List<T>> map = {};
    forEach((item) {
      var key = getKey(item);
      map.putIfAbsent(key, () => []).add(item);
    });
    return map;
  }
}
