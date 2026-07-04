import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
          onPressed: () {
            context.push("/habit/creation");
          },
          child: const Icon(Icons.add, size: 50),
        ),
      ),
    );
  }
}
