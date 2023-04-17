import 'business_logic/blocs.dart';
import 'data/data_providers/hive_box.dart';
import 'data/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'presentation/screens/screens.dart';
import 'presentation/theme/theme.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print('onEvent -- ${bloc.runtimeType}, $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('onTransition -- ${bloc.runtimeType}, $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- ${bloc.runtimeType}');
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveBoxProvider.init();
  Bloc.observer = MyBlocObserver();
  runApp(const MyAppState());
}

class MyAppState extends StatelessWidget {
  const MyAppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => ThemeRepository(HiveBoxProvider()),
        ),
        RepositoryProvider(
          create: (context) => NotesRepository(HiveBoxProvider()),
        ),
        RepositoryProvider(
            create: (context) => FoldersRepository(HiveBoxProvider()))
      ],
      child: MultiBlocProvider(providers: [
        BlocProvider(
          create: (context) => ThemeModeCubit(context.read<ThemeRepository>()),
        ),
        BlocProvider(
          create: (context) =>
              NotesBloc(context.read<NotesRepository>())..add(NotesStarted()),
        ),
        BlocProvider(
          create: (context) => FoldersBloc(context.read<FoldersRepository>())
            ..add(FoldersStared()),
        )
      ], child: const MyApp()),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeModeCubit, ThemeModeState>(
      builder: (context, state) {
        bool isDark = (state as ThemeModeActive).isDarkTheme;
        return MaterialApp(
          title: 'Notes APP',
          theme: ThemeApp.themeLight,
          darkTheme: ThemeApp.themeDataDark,
          themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
          initialRoute: '/home',
          routes: {'/home': (context) => const HomeScreen()},
        );
      },
    );
  }
}
