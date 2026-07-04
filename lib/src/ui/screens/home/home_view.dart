import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_tracker/src/domain/repostiories/active_user_repository.dart';
import 'package:habit_tracker/src/ui/core/shared/home_bottom_navbar.dart';
import 'package:habit_tracker/src/ui/core/shared/home_navbar.dart';
import 'package:habit_tracker/src/ui/core/theme/color_palette.dart';
import 'package:habit_tracker/src/ui/core/theme/raw.dart';
import 'package:habit_tracker/src/ui/core/theme/spacings.dart';
import 'package:habit_tracker/src/ui/core/theme/text_levels.dart';
import 'package:habit_tracker/src/ui/screens/home/create_habit_button.dart';
import 'package:habit_tracker/src/ui/screens/home/day_widgets.dart';
import 'package:habit_tracker/src/ui/screens/home/home_viewmodel.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<StatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final homeViewModel = context.watch<HomeViewmodel>();
    final activeUserRepo = context.watch<ActiveUserRepository>();
    final activeUser = activeUserRepo.getActiveUser();
    final isPopupActive = homeViewModel.popUpWidget != null;

    return Scaffold(
      appBar: HomeNavbar(activeUser: activeUser),
      floatingActionButton: !isPopupActive
          ? CreateHabitButton()
          : SizedBox.shrink(),
      bottomNavigationBar: const HomeBottomNavbar(name: ScreenNames.Home),
      body: _HomeViewBody(),
    );
  }
}

class _HomeViewBody extends StatefulWidget {
  const _HomeViewBody();

  @override
  State<StatefulWidget> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<_HomeViewBody> {
  @override
  Widget build(BuildContext context) {
    final homeViewModel = context.watch<HomeViewmodel>();

    return Stack(
      children: [
        Padding(
          padding: EdgeInsetsGeometry.only(
            top: Spacings.loose,
            left: Spacings.spacious,
            right: Spacings.spacious,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Text(DateFormat('EEE, MMMM d').format(DateTime.now())),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Focus Today").heading(),
                  TextButton(
                    onPressed: () => {context.push("/report")},
                    child: Row(
                      children: [
                        Text(
                          "Stats",
                          style: TextStyle(
                            color: ColorPalette.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: rawProperties.textSize.size500.toDouble(),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsGeometry.only(left: Spacings.cozy),
                          child: Text(
                            ">",
                            style: TextStyle(
                              color: ColorPalette.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: rawProperties.textSize.size500
                                  .toDouble(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              _WeeklyConsistency(
                weeklyPercent: 0.8,
                statusPerWeek: [true, false],
              ),
              Padding(
                padding: EdgeInsetsGeometry.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Priority habits".toUpperCase()).heading(),
                    Container(
                      decoration: BoxDecoration(
                        border: BoxBorder.all(width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      padding: EdgeInsets.only(
                        left: Spacings.tight,
                        right: Spacings.tight,
                      ),
                      child: Text(
                        "4 left",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ), //STATE
                    ),
                  ],
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: homeViewModel.getHabitsForToday(),
                  builder: (ctx, snap) {
                    String? userMessage;
                    if (snap.connectionState == ConnectionState.waiting) {
                      userMessage = 'Loading...';
                    } else if (snap.hasError) {
                      debugPrint(
                        'Failed to load today\'s habits: ${snap.error}',
                      );
                      userMessage = 'Could not load habits';
                    } else if (snap.data == null) {
                      userMessage = "No data";
                    } else if (snap.data!.isEmpty) {
                      userMessage = "No habits for today";
                    }
                    return Padding(
                      padding: EdgeInsetsGeometry.only(top: Spacings.relaxed),
                      child: userMessage != null
                          ? Center(child: Text(userMessage).caption())
                          : Column(
                              children: snap.data!.map((habitWithDate) {
                                return Container(
                                  child: Text(habitWithDate.habit.name),
                                );
                              }).toList(),
                            ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        if (homeViewModel.popUpWidget != null)
          Positioned.fill(child: homeViewModel.popUpWidget!),
      ],
    );
  }
}

class _WeeklyConsistency extends StatelessWidget {
  const _WeeklyConsistency({
    required this.weeklyPercent,
    required this.statusPerWeek,
  });
  final double weeklyPercent;
  final List<bool> statusPerWeek;
  static const weekDays = ["M", "T", "W", "T", "F", "S", 'S'];

  DayStatusWidget dayStatusWidget(int i) {
    if (i >= statusPerWeek.length) {
      return UpcomingDayWidget();
    }
    return statusPerWeek[i] ? CompletedDayWidget() : MissedDayWidget();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: ColorPalette.primary.withAlpha((255 * 0.1).round()),
        ),
        child: Padding(
          padding: EdgeInsetsGeometry.only(
            left: 15,
            top: 8,
            bottom: 8,
            right: 15,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Weekly Consistency",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: rawProperties.textSize.size400.toDouble(),
                        ),
                      ),
                      Text("You're on fire! ${weeklyPercent * 10}% this week"),
                    ],
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.emoji_events_outlined,
                          color: ColorPalette.supportColor3,
                          size: 38,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsetsGeometry.only(
                  top: Spacings.tight,
                  bottom: Spacings.tight,
                ),
                child: Row(
                  spacing: Spacings.extraTight + 1,
                  children: List.generate(weekDays.length, (i) {
                    return Column(
                      children: [
                        Text(
                          weekDays[i],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        dayStatusWidget(i),
                      ],
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
