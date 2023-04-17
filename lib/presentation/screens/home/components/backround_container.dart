import '../../../../business_logic/blocs.dart';
import '../../../theme/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class BackgroundContainer extends StatelessWidget {
  final Widget child;
  const BackgroundContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeModeCubit, ThemeModeState>(
      builder: (context, state) {
        bool isDark = (state as ThemeModeActive).isDarkTheme;
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: isDark ? ColorsApp.grey : Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
          padding: const EdgeInsets.all(10.0),
          child: child,
        );
      },
    );
  }
}
