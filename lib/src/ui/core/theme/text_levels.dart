import 'package:flutter/material.dart';
import 'package:habit_tracker/src/ui/core/theme/color_palette.dart';
import 'package:habit_tracker/src/ui/core/theme/raw.dart';

export 'package:habit_tracker/src/ui/core/theme/hex_colors.dart';

class TextStylePalette {
  static final TextStyle title = TextStyle(
    fontFamily: rawProperties.families.primary,
    fontSize: rawProperties.textSize.size600.toDouble(),
    letterSpacing: rawProperties.lineSize.size50.toDouble(),
    fontWeight: rawProperties.fontWeight.bold,
  );
  static final TextStyle heading = TextStyle(
    fontFamily: rawProperties.families.primary,
    fontSize: rawProperties.textSize.size500.toDouble(),
    letterSpacing: rawProperties.lineSize.size50.toDouble(),
    fontWeight: rawProperties.fontWeight.bold,
  );
  static final TextStyle subheading = TextStyle(
    fontFamily: rawProperties.families.primary,
    fontSize: rawProperties.textSize.size500.toDouble(),
    letterSpacing: rawProperties.lineSize.size50.toDouble(),
    fontWeight: rawProperties.fontWeight.none,
  );
  static final TextStyle bodyText = TextStyle(
    fontFamily: rawProperties.families.secondary,
    fontSize: rawProperties.textSize.size400.toDouble(),
    letterSpacing: rawProperties.lineSize.size50.toDouble(),
    fontWeight: rawProperties.fontWeight.none,
  );
  static final TextStyle link = bodyText.copyWith(
    decoration: TextDecoration.underline,
    fontFamily: rawProperties.families.secondary,
    fontSize: rawProperties.textSize.size100.toDouble(),
    letterSpacing: rawProperties.lineSize.size100.toDouble(),
    fontWeight: rawProperties.fontWeight.none,
    color: ColorPalette.info,
  );
  static final TextStyle caption = TextStyle(
    fontFamily: rawProperties.families.secondary,
    fontSize: rawProperties.textSize.size200.toDouble(),
    letterSpacing: rawProperties.lineSize.size50.toDouble(),
    fontWeight: rawProperties.fontWeight.none,
    color: ColorPalette.neutral,
  );
  static final TextStyle overline = TextStyle(
    fontFamily: rawProperties.families.secondary,
    fontSize: rawProperties.textSize.size100.toDouble(),
    letterSpacing: rawProperties.lineSize.size200.toDouble(),
    fontWeight: rawProperties.fontWeight.none,
  );
}

extension TextStyleExtension on Text {
  Text title() => _withStyle(TextStylePalette.title, data);

  Text heading() => _withStyle(TextStylePalette.heading, data);

  Text subheading() => _withStyle(TextStylePalette.subheading, data);

  Text bodyText() => _withStyle(TextStylePalette.bodyText, data);

  Text link() => _withStyle(TextStylePalette.link, data);

  Text caption() => _withStyle(TextStylePalette.caption, data);

  Text overline() => _withStyle(TextStylePalette.overline, data?.toUpperCase());

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
