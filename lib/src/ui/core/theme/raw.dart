import 'dart:ui';

const rawProperties = RawProperties(
  borders: RawBorderSizes(
    size100: 0,
    size200: 2,
    size300: 4,
    size400: 6,
    size500: 10,
    size600: 16,
  ),
  spacings: RawSpacings(
    size0: 0,
    size50: 2,
    size100: 4,
    size200: 8,
    size300: 10,
    size400: 12,
    size500: 14,
    size600: 16,
    size700: 18,
    size800: 20,
    size900: 24,
    size1000: 30,
    size1100: 32,
    size1200: 40,
  ),
  families: RawFontFamilies(primary: 'Archivo', secondary: 'Inter'),
  textSize: RawTextSizes(
    size100: 11,
    size200: 12,
    size300: 13,
    size400: 14,
    size500: 20,
    size600: 26,
    size700: 32,
    size800: 48,
    size900: 64,
  ),
  lineSize: RawLineSizes(
    size50: 2,
    size100: 14,
    size200: 18,
    size300: 20,
    size400: 22,
    size500: 30,
    size600: 48,
    size700: 64,
    size800: 72,
    size900: 84,
  ),
  colors: RawColors(
    purple500: '#636AE8',
    rose: '#E8618C',
    turqois: '#22CCB2',
    purple200: '#7F55E0',
    orange: '#EA916E',
    red: '#de3b40',
    yellow: '#efb034',
    green: '#1dd75b',
    blue: '#379ae6',
    neutral600: '#525252',
  ),
  fontWeight: RawFontWeight(bold: FontWeight.bold, none: FontWeight.normal),
);

class RawProperties {
  const RawProperties({
    required this.borders,
    required this.spacings,
    required this.families,
    required this.textSize,
    required this.lineSize,
    required this.colors,
    required this.fontWeight,
  });

  final RawBorderSizes borders;
  final RawSpacings spacings;
  final RawFontFamilies families;
  final RawTextSizes textSize;
  final RawLineSizes lineSize;
  final RawColors colors;
  final RawFontWeight fontWeight;
}

class RawFontWeight {
  const RawFontWeight({required this.bold, required this.none});

  final FontWeight bold;
  final FontWeight none;
}

class RawBorderSizes {
  const RawBorderSizes({
    required this.size100,
    required this.size200,
    required this.size300,
    required this.size400,
    required this.size500,
    required this.size600,
  });

  final int size100;
  final int size200;
  final int size300;
  final int size400;
  final int size500;
  final int size600;
}

class RawSpacings {
  const RawSpacings({
    required this.size0,
    required this.size50,
    required this.size100,
    required this.size200,
    required this.size300,
    required this.size400,
    required this.size500,
    required this.size600,
    required this.size700,
    required this.size800,
    required this.size900,
    required this.size1000,
    required this.size1100,
    required this.size1200,
  });

  final int size0;
  final int size50;
  final int size100;
  final int size200;
  final int size300;
  final int size400;
  final int size500;
  final int size600;
  final int size700;
  final int size800;
  final int size900;
  final int size1000;
  final int size1100;
  final int size1200;
}

class RawFontFamilies {
  const RawFontFamilies({required this.primary, required this.secondary});

  final String primary;
  final String secondary;
}

class RawTextSizes {
  const RawTextSizes({
    required this.size100,
    required this.size200,
    required this.size300,
    required this.size400,
    required this.size500,
    required this.size600,
    required this.size700,
    required this.size800,
    required this.size900,
  });

  final int size100;
  final int size200;
  final int size300;
  final int size400;
  final int size500;
  final int size600;
  final int size700;
  final int size800;
  final int size900;
}

class RawLineSizes {
  const RawLineSizes({
    required this.size50,
    required this.size100,
    required this.size200,
    required this.size300,
    required this.size400,
    required this.size500,
    required this.size600,
    required this.size700,
    required this.size800,
    required this.size900,
  });

  final int size50;
  final int size100;
  final int size200;
  final int size300;
  final int size400;
  final int size500;
  final int size600;
  final int size700;
  final int size800;
  final int size900;
}

class RawColors {
  const RawColors({
    required this.purple500,
    required this.rose,
    required this.turqois,
    required this.purple200,
    required this.orange,
    required this.red,
    required this.yellow,
    required this.green,
    required this.blue,
    required this.neutral600,
  });

  final String purple500;
  final String rose;
  final String turqois;
  final String purple200;
  final String orange;
  final String red;
  final String yellow;
  final String green;
  final String blue;
  final String neutral600;
}
