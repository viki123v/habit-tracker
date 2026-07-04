import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_tracker/src/domain/repostiories/active_user_repository.dart';
import 'package:habit_tracker/src/domain/repostiories/habit_repository.dart';
import 'package:habit_tracker/src/ui/page_not_found/page_not_found_view.dart';
import 'package:habit_tracker/src/ui/screens/habit/creation/habit_creation.dart';
import 'package:habit_tracker/src/ui/screens/habit/details/habit_details.dart';
import 'package:habit_tracker/src/ui/screens/home/home_view.dart';
import 'package:habit_tracker/src/ui/screens/home/home_viewmodel.dart';
import 'package:habit_tracker/src/ui/screens/login/login_view.dart';
import 'package:habit_tracker/src/ui/screens/login/login_viewmodel.dart';
import 'package:habit_tracker/src/ui/screens/marketplace/marketplace_view.dart';
import 'package:habit_tracker/src/ui/screens/profile/prifle_view.dart';
import 'package:habit_tracker/src/ui/screens/report/report_view.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  errorBuilder: (context, state) => PageNotFoundView(),
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => ChangeNotifierProvider(
        create: (context) => LoginViewModel(context.read()),
        child: LoginView(),
      ),
      routes: [
        GoRoute(
          path: "home",
          builder: (ctx, state) => ChangeNotifierProvider(
            create: (ctx) => HomeViewmodel(
              ctx.read<HabitRepository>(),
              ctx.read<ActiveUserRepository>(),
            ),
            child: const HomeView(),
          ),
        ),
        GoRoute(
          path: "habit",
          routes: [
            GoRoute(path: "details", builder: (_, _) => HabitDetails()),
            GoRoute(
              path: "creation",
              builder: (ctx, state) =>
                  HabitCreation(habitRepository: ctx.watch()),
            ),
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
