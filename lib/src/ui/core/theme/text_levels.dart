import 'package:flutter/material.dart';
import 'package:habit_tracker/src/ui/core/theme/color_palette.dart';
import 'package:habit_tracker/src/ui/core/theme/raw.dart';

extension HexColors on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

class _TextStyling {
  static final TextStyle title = TextStyle(
    fontFamily: rawProperties.families.primary,
    fontSize: rawProperties.textSize.size900.toDouble(),
    letterSpacing: rawProperties.lineSize.size900.toDouble(),
    fontWeight: rawProperties.fontWeight.bold,
  );
  static final TextStyle heading = TextStyle(
    fontFamily: rawProperties.families.primary,
    fontSize: rawProperties.textSize.size700.toDouble(),
    letterSpacing: rawProperties.lineSize.size600.toDouble(),
    fontWeight: rawProperties.fontWeight.bold,
  );
  static final TextStyle subheading = TextStyle(
    fontFamily: rawProperties.families.primary,
    fontSize: rawProperties.textSize.size500.toDouble(),
    letterSpacing: rawProperties.lineSize.size500.toDouble(),
    fontWeight: rawProperties.fontWeight.none,
  );
  static final TextStyle bodyText = TextStyle(
    fontFamily: rawProperties.families.secondary,
    fontSize: rawProperties.textSize.size400.toDouble(),
    letterSpacing: rawProperties.lineSize.size400.toDouble(),
    fontWeight: rawProperties.fontWeight.none,
  );
  static final TextStyle link = bodyText.copyWith(
    decoration: TextDecoration.underline,
    fontFamily: rawProperties.families.secondary,
    fontSize: rawProperties.textSize.size100.toDouble(),
    letterSpacing: rawProperties.lineSize.size100.toDouble(),
    fontWeight: rawProperties.fontWeight.none,
    color: HexColors.fromHex(ColorPalette.info),
  );
  static final TextStyle caption = TextStyle(
    fontFamily: rawProperties.families.secondary,
    fontSize: rawProperties.textSize.size200.toDouble(),
    letterSpacing: rawProperties.lineSize.size300.toDouble(),
    fontWeight: rawProperties.fontWeight.none,
    color: HexColors.fromHex(ColorPalette.neutral),
  );
  static final TextStyle overline = TextStyle(
    fontFamily: rawProperties.families.secondary,
    fontSize: rawProperties.textSize.size100.toDouble(),
    letterSpacing: rawProperties.lineSize.size200.toDouble(),
    fontWeight: rawProperties.fontWeight.none,
  );
}

extension TextStyleExtension on Text {
  Text title() => _withStyle(_TextStyling.title, data);

  Text heading() => _withStyle(_TextStyling.heading, data);

  Text subheading() => _withStyle(_TextStyling.subheading, data);

  Text bodyText() => _withStyle(_TextStyling.bodyText, data);

  Text link() => _withStyle(_TextStyling.link, data);

  Text caption() => _withStyle(_TextStyling.caption, data);

  Text overline() => _withStyle(_TextStyling.overline, data?.toUpperCase());

  Text _withStyle(TextStyle textStyle, String? text) {
    final mergedStyle = style?.merge(textStyle) ?? textStyle;

    if (text != null) {
      return Text(
        text,
        key: key,
        style: mergedStyle,
        strutStyle: strutStyle,
        textAlign: textAlign,
        textDirection: textDirection,
        locale: locale,
        softWrap: softWrap,
        overflow: overflow,
        textScaler: textScaler,
        maxLines: maxLines,
        semanticsLabel: semanticsLabel,
        textWidthBasis: textWidthBasis,
        textHeightBehavior: textHeightBehavior,
        selectionColor: selectionColor,
      );
    }

    return Text.rich(
      textSpan!,
      key: key,
      style: mergedStyle,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaler: textScaler,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      selectionColor: selectionColor,
    );
  }
}
