import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageServices {
  static LocalStorageServices? _instance;
  factory LocalStorageServices() {
    _instance ??= LocalStorageServices._internal();
    return _instance!;
  }

  LocalStorageServices._internal();

  static LocalStorageServices get instance => _instance!;

  Future<SharedPreferences> _getStore() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  Future<int?> getInt(String key) async {
    return (await _getStore()).getInt(key);
  }

  Future<void> setInt(String key, int value) async {
    await (await _getStore()).setInt(key, value);
  }

  Future<List<int>> getIntList(String key) async {
    final listAsString = (await _getStore()).getStringList(key) ?? [];
    return listAsString.map(int.parse).toList();
  }

  Future<void> addToIntList(String key, int value) async {
    final listAsString = (await _getStore()).getStringList(key) ?? [];
    await (await _getStore()).setStringList(
      key,
      [...listAsString, value.toString()],
    );
  }

  Future<bool> getBool(String key) async {
    return (await _getStore()).getBool(key) ?? false;
  }

  Future<void> setBool(String key, {required bool value}) async {
    await (await _getStore()).setBool(key, value);
  }
}
