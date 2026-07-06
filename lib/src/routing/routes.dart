import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_tracker/src/ui/core/shared/footer/footer_view.dart';
import 'package:habit_tracker/src/ui/core/shared/naviagtion_bar/navigation_bar_view.dart';
import 'package:habit_tracker/src/ui/page_not_found/page_not_found_view.dart';
import 'package:habit_tracker/src/ui/screens/check_theme/check_theme_view.dart';
import 'package:habit_tracker/src/ui/screens/habit/creation/habit_creation.dart';
import 'package:habit_tracker/src/ui/screens/habit/details/habit_details.dart';
import 'package:habit_tracker/src/ui/screens/home/home_view.dart';
import 'package:habit_tracker/src/ui/screens/login/login_view.dart';
import 'package:habit_tracker/src/ui/screens/marketplace/marketplace_view.dart';
import 'package:habit_tracker/src/ui/screens/profile/prifle_view.dart';
import 'package:habit_tracker/src/ui/screens/report/report_view.dart';

final router = GoRouter(
  errorBuilder: (context, state) => PageNotFoundView(),
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => Scaffold(
        body: ThemePreviewView()
      ),
      routes: [
        GoRoute(path: "login", builder: (_, _) => LoginView()),
        GoRoute(path: "home", builder: (_, _) => HomeView()),
        GoRoute(
          path: "habit",
          routes: [
            GoRoute(path: "details", builder: (_, _) => HabitDetails()),
            GoRoute(path: "creation", builder: (_, _) => HabitCreation()),
          ],
          builder: (_, _) => Scaffold(),
        ),
        GoRoute(path: "marketplace", builder: (_, _) => MarketplaceView()),
        GoRoute(path: "report", builder: (_, _) => ReportView()),
        GoRoute(path: "profile", builder: (_, _) => ProfileView()),
      ],
    ),
  ],
);
