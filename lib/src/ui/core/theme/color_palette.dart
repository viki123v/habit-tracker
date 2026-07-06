import 'package:flutter/material.dart';
import 'package:habit_tracker/src/ui/core/theme/hex_colors.dart';
import 'package:habit_tracker/src/ui/core/theme/raw.dart';

class ColorPalette {
  static final Color primary = HexColors.fromHex(
    rawProperties.colors.purple500,
  );
  static final Color secondary = HexColors.fromHex(rawProperties.colors.rose);
  static final Color supportColor1 = HexColors.fromHex(
    rawProperties.colors.turqois,
  );
  static final Color supportColor2 = HexColors.fromHex(
    rawProperties.colors.purple200,
  );
  static final Color supportColor3 = HexColors.fromHex(
    rawProperties.colors.orange,
  );

  static final Color neutral = HexColors.fromHex(
    rawProperties.colors.neutral600,
  );

  static final Color danger = HexColors.fromHex(rawProperties.colors.red);
  static final Color warning = HexColors.fromHex(rawProperties.colors.yellow);
  static final Color success = HexColors.fromHex(rawProperties.colors.green);
  static final Color info = HexColors.fromHex(rawProperties.colors.blue);
}
