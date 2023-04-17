part of 'theme_mode_cubit.dart';

abstract class ThemeModeState extends Equatable {}

class ThemeModeActive extends ThemeModeState {
  final bool isDarkTheme;
  ThemeModeActive({required this.isDarkTheme});
  @override
  List<Object?> get props => [isDarkTheme];
}
