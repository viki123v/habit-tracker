import 'package:flutter/material.dart';
import 'package:habit_tracker/src/data/dao/active_user_dao.dart';
import 'package:habit_tracker/src/data/dao/habit_dao.dart';
import 'package:habit_tracker/src/data/database.dart';
import 'package:habit_tracker/src/data/migrations.dart';
import 'package:habit_tracker/src/domain/repostiories/active_user_repository.dart';
import 'package:habit_tracker/src/domain/repostiories/habit_repository.dart';
import 'package:habit_tracker/src/routing/routes.dart';
import 'package:habit_tracker/src/ui/core/theme/app_theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = await $FloorAppDatabase
      .databaseBuilder('habit_tracker.db')
      .addMigrations(migrations)
      .build();

  runApp(
    MultiProvider(
      providers: [
        Provider<AppDatabase>.value(value: database),
        Provider<ActiveUserDao>.value(value: database.activeUserDao),
        ChangeNotifierProvider<ActiveUserRepository>(
          create: (context) =>
              ActiveUserRepository(context.read<ActiveUserDao>()),
        ),
        Provider<HabitDao>.value(value: database.habitDao),
        Provider<HabitRepository>(
          create: (context) => HabitRepository(context.read<HabitDao>()),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: router,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: defaultColorMode,
      ),
    ),
  );
}
