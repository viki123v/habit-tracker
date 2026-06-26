import 'package:flutter/material.dart';

class NavigationBarView extends StatelessWidget implements PreferredSizeWidget {
  const NavigationBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar();
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
