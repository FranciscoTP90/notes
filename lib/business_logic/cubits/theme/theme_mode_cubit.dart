import '../../../data/repositories/repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'theme_mode_state.dart';

class ThemeModeCubit extends Cubit<ThemeModeState> {
  final ThemeRepository _themeRepository;
  ThemeModeCubit(this._themeRepository)
      : super(ThemeModeActive(isDarkTheme: _themeRepository.isDarkTheme()));

  void changeThemeMode() {
    final value = (state as ThemeModeActive).isDarkTheme;
    _themeRepository.changeThemeMode(!value);
    emit(ThemeModeActive(isDarkTheme: !value));
  }
}
