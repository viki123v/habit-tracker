import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_tracker/src/ui/core/theme/color_palette.dart';

class HomeBottomNavbar extends StatelessWidget {
  const HomeBottomNavbar({super.key, required this.navigationShell});

  static const _bottomBarHeight = 70.0;
  final StatefulNavigationShell navigationShell;

  static const _items = [
    (label: 'Home', icon: Icons.home_outlined),
    (label: 'Market', icon: Icons.storefront_outlined),
    (label: 'Profile', icon: Icons.person_outline),
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
        children: _items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final isActive = navigationShell.currentIndex == index;

          return IconButton(
            padding: EdgeInsets.zero,
            onPressed: () =>
                navigationShell.goBranch(index, initialLocation: isActive),
            icon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  size: _bottomBarHeight * 0.52,
                  color: isActive ? ColorPalette.primary : Colors.black,
                  fontWeight: FontWeight.w500,
                ),
                Text(
                  item.label,
                  style: TextStyle(
                    color: isActive ? ColorPalette.primary : Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
