extension MapX on Map {
  T? get<T>(String key) {
    return this[key] as T;
  }

  String? getSting(String key, {String? orElse}) {
    return containsKey(key) ? get<String>(key) : orElse;
  }

  bool? getBool(String key, {bool? orElse}) {
    return containsKey(key) ? get<bool>(key) : orElse;
  }
}
