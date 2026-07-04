import 'package:flutter/material.dart';
import 'package:habit_tracker/src/domain/repostiories/active_user_repository.dart';
import 'package:habit_tracker/src/ui/core/shared/home_navbar.dart';
import 'package:habit_tracker/src/ui/screens/home/create_habit_button.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final activeUserRepo = context.watch<ActiveUserRepository>();
    final activeUser = activeUserRepo.getActiveUser();

    return Scaffold(
      appBar: HomeNavbar(activeUser: activeUser),
      floatingActionButton: CreateHabitButton(),
    );
  }
}
