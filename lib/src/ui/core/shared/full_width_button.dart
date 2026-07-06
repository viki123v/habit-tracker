import 'package:flutter/material.dart';

import '../theme.dart';

class PrimaryFullWidthButton extends StatelessWidget {
  const PrimaryFullWidthButton(this.title, {super.key, this.onPressed});

  final String title;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: Spacings.spacious),
      child: SizedBox(
        width: double.infinity,
        child: FilledButton(
          onPressed: onPressed,
          style: FilledButton.styleFrom(
            backgroundColor: ColorPalette.primary,
            disabledBackgroundColor: ColorPalette.primary,
            foregroundColor: Colors.white,
            disabledForegroundColor: Colors.white,
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
