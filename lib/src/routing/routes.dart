import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_tracker/src/data/models/active_user.dart';
import 'package:habit_tracker/src/domain/repostiories/active_user_repository.dart';
import 'package:habit_tracker/src/ui/page_not_found/page_not_found_view.dart';
import 'package:habit_tracker/src/ui/screens/habit/creation/habit_creation.dart';
import 'package:habit_tracker/src/ui/screens/habit/details/habit_details.dart';
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
        child: const LoginView(),
      ),
      routes: [
        GoRoute(path: "home", builder: (_, _) => const _TestSqlite()),
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

class _TestSqlite extends StatefulWidget {
  const _TestSqlite();

  @override
  State<_TestSqlite> createState() => _TestSqliteState();
}

class _TestSqliteState extends State<_TestSqlite> {
  late final Future<ActiveUser?> _activeUserFuture;

  @override
  void initState() {
    super.initState();
    _activeUserFuture = context
        .read<ActiveUserRepository>()
        .getActiveUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<ActiveUser?>(
          future: _activeUserFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            if (snapshot.hasError) {
              return Text('Could not load the active user: ${snapshot.error}');
            }

            final activeUser = snapshot.data;
            if (activeUser == null) {
              return const Text('No active user found.');
            }

            return Text('Active user: ${activeUser.email}');
          },
        ),
      ),
    );
  }
}
