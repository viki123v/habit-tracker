import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_tracker/src/ui/screens/home/home_viewmodel.dart';
import 'package:provider/provider.dart';

class CreateHabitButton extends StatelessWidget {
  const CreateHabitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        width: 60,
        height: 60,
        child: FilledButton(
          style: FilledButton.styleFrom(
            shape: const CircleBorder(),
            padding: EdgeInsets.zero,
          ),
          onPressed: () async {
            await context.push("/habit/creation");
            if (context.mounted) {
              final homeViewmodel = context.read<HomeViewmodel>();
              await homeViewmodel.refreshHabitsForToday();
              await homeViewmodel.refreshHasHabits();
            }
          },
          child: const Icon(Icons.add, size: 50),
        ),
      ),
    );
  }
}
