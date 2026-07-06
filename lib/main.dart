import 'package:flutter/material.dart';
import 'package:habit_tracker/src/routing/routes.dart';
import 'package:habit_tracker/src/ui/core/theme/app_theme.dart';

void main() => runApp(
  MaterialApp.router(
    routerConfig: router,
    theme: lightTheme,
    darkTheme: darkTheme,
    themeMode: defaultColorMode,
  ),
);
