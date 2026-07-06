import 'package:flutter/material.dart';
import 'package:habit_tracker/src/ui/core/theme/border_sizings.dart';
import 'package:habit_tracker/src/ui/core/theme/color_palette.dart';
import 'package:habit_tracker/src/ui/core/theme/raw.dart';
import 'package:habit_tracker/src/ui/core/theme/shadows.dart';

final lightTheme = _buildTheme(Brightness.light);
final darkTheme = _buildTheme(Brightness.dark);
final theme = lightTheme;
const defaultColorMode = ThemeMode.light;
final brandLogo = "assets/images/logo.png";

@immutable
class AppShadows extends ThemeExtension<AppShadows> {
  const AppShadows({
    required this.xs,
    required this.s,
    required this.m,
    required this.l,
    required this.xl,
  });

  final List<BoxShadow> xs;
  final List<BoxShadow> s;
  final List<BoxShadow> m;
  final List<BoxShadow> l;
  final List<BoxShadow> xl;

  @override
  AppShadows copyWith({
    List<BoxShadow>? xs,
    List<BoxShadow>? s,
    List<BoxShadow>? m,
    List<BoxShadow>? l,
    List<BoxShadow>? xl,
  }) {
    return AppShadows(
      xs: xs ?? this.xs,
      s: s ?? this.s,
      m: m ?? this.m,
      l: l ?? this.l,
      xl: xl ?? this.xl,
    );
  }

  @override
  AppShadows lerp(ThemeExtension<AppShadows>? other, double t) {
    if (other is! AppShadows) return this;

    return AppShadows(
      xs: BoxShadow.lerpList(xs, other.xs, t) ?? xs,
      s: BoxShadow.lerpList(s, other.s, t) ?? s,
      m: BoxShadow.lerpList(m, other.m, t) ?? m,
      l: BoxShadow.lerpList(l, other.l, t) ?? l,
      xl: BoxShadow.lerpList(xl, other.xl, t) ?? xl,
    );
  }
}

ThemeData _buildTheme(Brightness brightness) {
  final isDark = brightness == Brightness.dark;
  final colorScheme = _colorScheme(brightness);
  final textTheme = _textTheme(colorScheme);
  final surfaceColor = isDark ? const Color(0xFF181818) : Colors.white;
  final outlineColor = _withOpacity(colorScheme.outline, 0.24);
  final mediumRadius = RoundedRectangleBorder(borderRadius: BorderSizings.m);
  final smallRadius = RoundedRectangleBorder(borderRadius: BorderSizings.s);

  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorScheme: colorScheme,
    fontFamily: rawProperties.families.secondary,
    scaffoldBackgroundColor: colorScheme.surface,
    canvasColor: colorScheme.surface,
    cardColor: surfaceColor,
    dividerColor: outlineColor,
    textTheme: textTheme,
    primaryTextTheme: textTheme,
    appBarTheme: AppBarThemeData(
      elevation: 0,
      centerTitle: false,
      backgroundColor: colorScheme.surface,
      foregroundColor: colorScheme.onSurface,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: textTheme.titleLarge,
      iconTheme: IconThemeData(color: colorScheme.onSurface),
    ),
    cardTheme: CardThemeData(
      color: surfaceColor,
      elevation: 2,
      margin: EdgeInsets.zero,
      shadowColor: _withOpacity(Colors.black, isDark ? 0.5 : 0.18),
      surfaceTintColor: Colors.transparent,
      shape: mediumRadius,
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: surfaceColor,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderSizings.l),
      titleTextStyle: textTheme.headlineSmall,
      contentTextStyle: textTheme.bodyMedium,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: surfaceColor,
      modalBackgroundColor: surfaceColor,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: BorderSizings.l.topLeft),
      ),
    ),
    inputDecorationTheme: InputDecorationThemeData(
      filled: true,
      fillColor: isDark ? const Color(0xFF202020) : const Color(0xFFF7F7F8),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: _inputBorder(outlineColor),
      enabledBorder: _inputBorder(outlineColor),
      focusedBorder: _inputBorder(colorScheme.primary, width: 1.5),
      errorBorder: _inputBorder(colorScheme.error),
      focusedErrorBorder: _inputBorder(colorScheme.error, width: 1.5),
      labelStyle: textTheme.bodyMedium?.copyWith(
        color: colorScheme.onSurfaceVariant,
      ),
      hintStyle: textTheme.bodyMedium?.copyWith(
        color: colorScheme.onSurfaceVariant,
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        disabledBackgroundColor: _withOpacity(colorScheme.onSurface, 0.12),
        disabledForegroundColor: _withOpacity(colorScheme.onSurface, 0.38),
        textStyle: textTheme.labelLarge,
        shape: smallRadius,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        disabledBackgroundColor: _withOpacity(colorScheme.onSurface, 0.12),
        disabledForegroundColor: _withOpacity(colorScheme.onSurface, 0.38),
        elevation: 2,
        shadowColor: _withOpacity(Colors.black, isDark ? 0.5 : 0.18),
        textStyle: textTheme.labelLarge,
        shape: smallRadius,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: colorScheme.primary,
        disabledForegroundColor: _withOpacity(colorScheme.onSurface, 0.38),
        side: BorderSide(color: outlineColor),
        textStyle: textTheme.labelLarge,
        shape: smallRadius,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: colorScheme.primary,
        disabledForegroundColor: _withOpacity(colorScheme.onSurface, 0.38),
        textStyle: textTheme.labelLarge,
        shape: smallRadius,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: colorScheme.secondary,
      foregroundColor: colorScheme.onSecondary,
      shape: RoundedRectangleBorder(borderRadius: BorderSizings.xl),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: colorScheme.secondaryContainer,
      selectedColor: colorScheme.primaryContainer,
      disabledColor: _withOpacity(colorScheme.onSurface, 0.12),
      labelStyle: textTheme.labelMedium,
      secondaryLabelStyle: textTheme.labelMedium?.copyWith(
        color: colorScheme.onPrimaryContainer,
      ),
      shape: smallRadius,
      side: BorderSide(color: outlineColor),
    ),
    listTileTheme: ListTileThemeData(
      iconColor: colorScheme.primary,
      textColor: colorScheme.onSurface,
      titleTextStyle: textTheme.titleMedium,
      subtitleTextStyle: textTheme.bodyMedium?.copyWith(
        color: colorScheme.onSurfaceVariant,
      ),
      shape: smallRadius,
    ),
    dividerTheme: DividerThemeData(color: outlineColor, space: 1, thickness: 1),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: colorScheme.primary,
      linearTrackColor: colorScheme.primaryContainer,
      circularTrackColor: colorScheme.primaryContainer,
    ),
    checkboxTheme: _checkboxTheme(colorScheme),
    radioTheme: _radioTheme(colorScheme),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return colorScheme.primary;
        return colorScheme.outline;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return colorScheme.primaryContainer;
        }
        return _withOpacity(colorScheme.outline, 0.24);
      }),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: colorScheme.inverseSurface,
      contentTextStyle: textTheme.bodyMedium?.copyWith(
        color: colorScheme.onInverseSurface,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderSizings.s),
      behavior: SnackBarBehavior.floating,
    ),
    extensions: const [
      AppShadows(
        xs: ShadowPallette.xs,
        s: ShadowPallette.s,
        m: ShadowPallette.m,
        l: ShadowPallette.l,
        xl: ShadowPallette.xl,
      ),
    ],
  );
}

ColorScheme _colorScheme(Brightness brightness) {
  final isDark = brightness == Brightness.dark;
  final primary = ColorPalette.primary;
  final secondary = ColorPalette.secondary;
  final tertiary = ColorPalette.supportColor1;
  final neutral = ColorPalette.neutral;

  return ColorScheme(
    brightness: brightness,
    primary: primary,
    onPrimary: Colors.white,
    primaryContainer: isDark
        ? _withOpacity(primary, 0.32)
        : _tint(primary, 0.86),
    onPrimaryContainer: isDark ? _tint(primary, 0.84) : _shade(primary, 0.34),
    secondary: secondary,
    onSecondary: Colors.white,
    secondaryContainer: isDark
        ? _withOpacity(secondary, 0.28)
        : _tint(secondary, 0.88),
    onSecondaryContainer: isDark
        ? _tint(secondary, 0.86)
        : _shade(secondary, 0.32),
    tertiary: tertiary,
    onTertiary: Colors.white,
    tertiaryContainer: isDark
        ? _withOpacity(tertiary, 0.26)
        : _tint(tertiary, 0.86),
    onTertiaryContainer: isDark
        ? _tint(tertiary, 0.84)
        : _shade(tertiary, 0.34),
    error: ColorPalette.danger,
    onError: Colors.white,
    errorContainer: isDark
        ? _withOpacity(ColorPalette.danger, 0.3)
        : _tint(ColorPalette.danger, 0.86),
    onErrorContainer: isDark
        ? _tint(ColorPalette.danger, 0.84)
        : _shade(ColorPalette.danger, 0.35),
    surface: isDark ? const Color(0xFF101010) : const Color(0xFFFCFCFD),
    onSurface: isDark ? const Color(0xFFF4F4F5) : const Color(0xFF18181B),
    onSurfaceVariant: isDark ? const Color(0xFFC8C8CC) : neutral,
    outline: isDark ? const Color(0xFF6F6F76) : const Color(0xFFD8D8DE),
    outlineVariant: isDark ? const Color(0xFF36363C) : const Color(0xFFE9E9EE),
    shadow: Colors.black,
    scrim: Colors.black,
    inverseSurface: isDark ? const Color(0xFFF4F4F5) : const Color(0xFF26262B),
    onInverseSurface: isDark ? const Color(0xFF18181B) : Colors.white,
    inversePrimary: isDark ? _tint(primary, 0.62) : _shade(primary, 0.18),
    surfaceTint: primary,
  );
}

TextTheme _textTheme(ColorScheme colorScheme) {
  final title = _textStyle(
    family: rawProperties.families.primary,
    fontSize: rawProperties.textSize.size900,
    lineSize: rawProperties.lineSize.size900,
    weight: rawProperties.fontWeight.bold,
    color: colorScheme.onSurface,
  );
  final heading = _textStyle(
    family: rawProperties.families.primary,
    fontSize: rawProperties.textSize.size700,
    lineSize: rawProperties.lineSize.size600,
    weight: rawProperties.fontWeight.bold,
    color: colorScheme.onSurface,
  );
  final subheading = _textStyle(
    family: rawProperties.families.primary,
    fontSize: rawProperties.textSize.size500,
    lineSize: rawProperties.lineSize.size500,
    weight: rawProperties.fontWeight.none,
    color: colorScheme.onSurface,
  );
  final bodyText = _textStyle(
    family: rawProperties.families.secondary,
    fontSize: rawProperties.textSize.size400,
    lineSize: rawProperties.lineSize.size400,
    weight: rawProperties.fontWeight.none,
    color: colorScheme.onSurface,
  );
  final caption = _textStyle(
    family: rawProperties.families.secondary,
    fontSize: rawProperties.textSize.size200,
    lineSize: rawProperties.lineSize.size300,
    weight: rawProperties.fontWeight.none,
    color: colorScheme.onSurfaceVariant,
  );
  final overline = _textStyle(
    family: rawProperties.families.secondary,
    fontSize: rawProperties.textSize.size100,
    lineSize: rawProperties.lineSize.size200,
    weight: rawProperties.fontWeight.none,
    color: colorScheme.onSurfaceVariant,
    letterSpacing: 0.8,
  );

  return TextTheme(
    displayLarge: title,
    displayMedium: title.copyWith(
      fontSize: rawProperties.textSize.size800.toDouble(),
      height: _lineHeight(
        rawProperties.lineSize.size800,
        rawProperties.textSize.size800,
      ),
    ),
    displaySmall: heading,
    headlineLarge: heading,
    headlineMedium: heading.copyWith(
      fontSize: rawProperties.textSize.size600.toDouble(),
      height: _lineHeight(
        rawProperties.lineSize.size600,
        rawProperties.textSize.size600,
      ),
    ),
    headlineSmall: subheading,
    titleLarge: subheading,
    titleMedium: bodyText.copyWith(fontWeight: rawProperties.fontWeight.bold),
    titleSmall: caption.copyWith(fontWeight: rawProperties.fontWeight.bold),
    bodyLarge: bodyText.copyWith(
      fontSize: rawProperties.textSize.size500.toDouble(),
      height: _lineHeight(
        rawProperties.lineSize.size500,
        rawProperties.textSize.size500,
      ),
    ),
    bodyMedium: bodyText,
    bodySmall: caption,
    labelLarge: bodyText.copyWith(fontWeight: rawProperties.fontWeight.bold),
    labelMedium: caption.copyWith(fontWeight: rawProperties.fontWeight.bold),
    labelSmall: overline,
  );
}

TextStyle _textStyle({
  required String family,
  required int fontSize,
  required int lineSize,
  required FontWeight weight,
  required Color color,
  double letterSpacing = 0,
}) {
  return TextStyle(
    fontFamily: family,
    fontSize: fontSize.toDouble(),
    height: _lineHeight(lineSize, fontSize),
    letterSpacing: letterSpacing,
    fontWeight: weight,
    color: color,
  );
}

InputBorder _inputBorder(Color color, {double width = 1}) {
  return OutlineInputBorder(
    borderRadius: BorderSizings.m,
    borderSide: BorderSide(color: color, width: width),
  );
}

CheckboxThemeData _checkboxTheme(ColorScheme colorScheme) {
  return CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) return colorScheme.primary;
      return Colors.transparent;
    }),
    checkColor: const WidgetStatePropertyAll(Colors.white),
    side: BorderSide(color: colorScheme.outline),
    shape: RoundedRectangleBorder(borderRadius: BorderSizings.xs),
  );
}

RadioThemeData _radioTheme(ColorScheme colorScheme) {
  return RadioThemeData(
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) return colorScheme.primary;
      return colorScheme.outline;
    }),
  );
}

double _lineHeight(int lineSize, int fontSize) => lineSize / fontSize;

Color _tint(Color color, double amount) {
  return Color.lerp(color, Colors.white, amount)!;
}

Color _shade(Color color, double amount) {
  return Color.lerp(color, Colors.black, amount)!;
}

Color _withOpacity(Color color, double opacity) {
  return color.withValues(alpha: opacity);
}
