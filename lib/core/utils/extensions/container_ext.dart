extension MapExt on Map<dynamic, dynamic> {
  void removeIfContains(dynamic key) {
    if (containsKey(key)) {
      remove(key);
    }
  }
}
