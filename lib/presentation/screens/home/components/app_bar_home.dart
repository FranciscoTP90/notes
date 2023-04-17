import '../../../../business_logic/blocs.dart';
import '../../../theme/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class AppBarHome extends StatelessWidget with PreferredSizeWidget {
  const AppBarHome({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Notes"),
      leading: Container(
        margin: const EdgeInsets.only(left: 15.0),
        child: const CircleAvatar(
          child: FittedBox(
            child: Text(
              "FT",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      actions: const [_IconButton()],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _IconButton extends StatelessWidget {
  const _IconButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeModeCubit, ThemeModeState>(
      builder: (context, state) {
        bool isDark = (state as ThemeModeActive).isDarkTheme;

        if (isDark) {
          return IconButton(
              onPressed: () {
                context.read<ThemeModeCubit>().changeThemeMode();
              },
              icon: const Icon(
                Icons.sunny,
                color: ColorsApp.yellow,
              ));
        } else {
          return IconButton(
              onPressed: () {
                context.read<ThemeModeCubit>().changeThemeMode();
              },
              icon: const Icon(
                Ionicons.moon,
                color: ColorsApp.grey,
              ));
        }
      },
    );
  }
}
