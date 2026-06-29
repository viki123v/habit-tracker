import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:habit_tracker/src/ui/core/theme/text_levels.dart';

class WeeklyWidget extends StatefulWidget {
  const WeeklyWidget({super.key});

  @override
  State<StatefulWidget> createState() => _WeeklyDays();
}

class _WeeklyDays extends State<WeeklyWidget> {
  final _selectedDays = <int>[1];
  static const _days = ["M", "T", "W", "T", "F", "S", "S"];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
            PointerDeviceKind.trackpad,
            PointerDeviceKind.stylus,
          },
        ),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: _days.length,
          separatorBuilder: (_, _) => const SizedBox(width: 10),
          itemBuilder: (context, index) {
            if (_selectedDays.contains(index)) {
              return FilledButton(
                style: FilledButton.styleFrom(
                  fixedSize: const Size.square(52),
                  padding: EdgeInsets.zero,
                  shape: const CircleBorder(),
                ),
                onPressed: () {},
                child: Text(_days[index]).bodyText(),
              );
            }

            return OutlinedButton(
              style: OutlinedButton.styleFrom(
                fixedSize: const Size.square(52),
                padding: EdgeInsets.zero,
                shape: const CircleBorder(),
                backgroundColor: Colors.grey.withAlpha((.03 * 255).round()),
              ),
              onPressed: () {},
              child: Text(_days[index]).bodyText(),
            );
          },
        ),
      ),
    );
  }
}