import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_tracker/src/ui/core/theme/color_palette.dart';

enum ScreenNames { Home, Market, Profile }

class HomeBottomNavbar extends StatelessWidget {
  const HomeBottomNavbar({super.key, required ScreenNames name})
    : activeScreenName = name;

  static const _bottomBarHeight = 70.0;
  final ScreenNames activeScreenName;

  static const _items = [
    (label: 'Home', icon: Icons.home_outlined, route: "/"),
    (label: 'Market', icon: Icons.storefront_outlined, route: "/marketplace"),
    (label: 'Profile', icon: Icons.person_outline, route: "/profile"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _bottomBarHeight,
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFFE5E7EB), width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _items
            .map(
              (item) => IconButton(
                padding: EdgeInsets.zero,
                onPressed: () => context.go(item.route),
                icon: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      item.icon,
                      size: _bottomBarHeight * 0.52,
                      color: activeScreenName.name == item.label
                          ? ColorPalette.primary
                          : Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    Text(
                      item.label,
                      style: TextStyle(
                        color: activeScreenName.name == item.label
                            ? ColorPalette.primary
                            : Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
