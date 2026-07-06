import 'package:flutter/material.dart';
import 'package:habit_tracker/src/data/models/habit.dart';
import 'package:habit_tracker/src/data/models/habit_with_dates.dart';
import 'package:habit_tracker/src/ui/core/theme/color_palette.dart';
import 'package:habit_tracker/src/ui/core/theme/raw.dart';
import 'package:habit_tracker/src/ui/core/theme/spacings.dart';

class HabitItem extends StatelessWidget {
  const HabitItem({
    super.key,
    required this.habitWithDates,
    required this.onDone,
  });

  final HabitWithDates habitWithDates;
  final VoidCallback onDone;

  Habit get habit => habitWithDates.habit;

  @override
  Widget build(BuildContext context) {
    final flameCount = (habit.priorityLevel + 1).clamp(1, 5);

    return Container(
      padding: EdgeInsets.all(Spacings.comfortable),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(15),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            habit.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: rawProperties.families.primary,
              fontSize: rawProperties.textSize.size500.toDouble(),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: Spacings.cozy),
          Wrap(
            spacing: Spacings.cozy,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Spacings.cozy,
                  vertical: Spacings.extraTight,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(10),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Text(
                  _titleCase(habit.type),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  flameCount,
                  (_) => Icon(
                    Icons.local_fire_department_outlined,
                    color: ColorPalette.secondary,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: Spacings.relaxed),
          SizedBox(
            width: double.infinity,
            child: _HabitActionButton(
              icon: Icons.check_rounded,
              label: 'DONE',
              onPressed: onDone,
            ),
          ),
        ],
      ),
    );
  }

  String _titleCase(String value) {
    if (value.isEmpty) return value;
    return '${value[0].toUpperCase()}${value.substring(1).toLowerCase()}';
  }
}

class _HabitActionButton extends StatelessWidget {
  const _HabitActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withAlpha(7),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: Spacings.comfortable),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 20, color: ColorPalette.neutral),
              SizedBox(height: Spacings.extraTight),
              Text(
                label,
                style: TextStyle(
                  color: ColorPalette.neutral,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
