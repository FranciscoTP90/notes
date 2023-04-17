import '../data_providers/hive_box.dart';

class ThemeRepository {
  final HiveBoxProvider _hiveBoxApp;

  ThemeRepository(this._hiveBoxApp);

  bool isDarkTheme() {
    return _hiveBoxApp.getThemeMode();
  }

  Future<void> changeThemeMode(bool value) async {
    await _hiveBoxApp.changeThemeMode(value);
  }
}
