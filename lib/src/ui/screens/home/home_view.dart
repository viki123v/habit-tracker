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
import 'package:habit_tracker/src/ui/screens/home/home_viewmodel.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget{
  const HomeView({super.key});

  @override
  State<StatefulWidget> createState() => _HomeViewState();
} 

class _HomeViewState extends State<HomeView>{
  @override
  Widget build(BuildContext context) {
    final homeViewModel = context.watch<HomeViewmodel>();
    final activeUserRepo = context.watch<ActiveUserRepository>();
    final activeUser = activeUserRepo.getActiveUser();
    final isPopupActive = homeViewModel.popUpWidget != null ; 

    return Scaffold(
      appBar: HomeNavbar(activeUser: activeUser),
      floatingActionButton: !isPopupActive ? CreateHabitButton() : SizedBox.shrink(),
      bottomNavigationBar: const HomeBottomNavbar(name: ScreenNames.Home),
      body: _HomeViewBody()
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
              FilledButton(onPressed: (){
                homeViewModel.markedHabitAsDone(10);
              }, child: Text("test"))
            ],
          ),
        ),
        if (homeViewModel.popUpWidget != null) Positioned.fill(child: homeViewModel.popUpWidget!),
      ],
    );
  }
}
