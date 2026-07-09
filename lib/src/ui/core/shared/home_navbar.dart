import 'package:flutter/material.dart';
import 'package:habit_tracker/src/data/models/active_user.dart';
import 'package:habit_tracker/src/ui/core/theme/app_theme.dart';
import 'package:habit_tracker/src/ui/core/theme/border_sizings.dart';
import 'package:habit_tracker/src/ui/core/theme/color_palette.dart';
import 'package:habit_tracker/src/ui/core/theme/raw.dart';
import 'package:habit_tracker/src/ui/core/theme/spacings.dart';

class HomeNavbar extends StatelessWidget implements PreferredSizeWidget {
  const HomeNavbar({super.key, required this.activeUser, this.title = 'Today'});

  final Future<ActiveUser?> activeUser;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      shape: const Border(
        bottom: BorderSide(color: Color(0xFFE5E7EB), width: 1),
      ),
      leading: Padding(
        padding: EdgeInsets.only(left: Spacings.cozy),
        child: Image.asset(brandLogo),
      ),
      leadingWidth: 64,
      title: Text(title),
      actions: [
        Center(
          child: Container(
            decoration: BoxDecoration(
              color: ColorPalette.primary.withAlpha(25),
              shape: BoxShape.rectangle,
              border: Border.all(width: 0.7, color: ColorPalette.primary),
              borderRadius: BorderSizings.xl,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: FutureBuilder<ActiveUser?>(
              future: activeUser,
              builder: (context, snapshot) {
                final user = snapshot.data;
                final imageFileName = user?.imageName;
                final imageName = imageFileName == null || imageFileName.isEmpty
                    ? 'assets/images/anonymousUser.png'
                    : 'assets/images/$imageFileName';

                return Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'POINTS',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: rawProperties.textSize.size100
                                  .toDouble(),
                              color: ColorPalette.primary,
                            ),
                          ),
                          Text(
                            (user?.points ?? 0).toString(),
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      SizedBox(width: Spacings.loose),
                      ClipOval(
                        child: Image.asset(
                          imageName,
                          width: 30,
                          height: 30,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.account_circle, size: 30),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
      actionsPadding: EdgeInsets.only(right: Spacings.cozy),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 13);
}
