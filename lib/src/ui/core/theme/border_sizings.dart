import 'package:flutter/cupertino.dart';
import 'package:habit_tracker/src/ui/core/theme/raw.dart';

class BorderSizings {
  static const BorderRadius none = BorderRadius.all(Radius.zero);
  static final BorderRadius xs = BorderRadius.all(
    Radius.circular(rawProperties.borders.size100.toDouble()),
  );
  static final BorderRadius s = BorderRadius.all(
    Radius.circular(rawProperties.borders.size300.toDouble()),
  );
  static final BorderRadius m = BorderRadius.all(
    Radius.circular(rawProperties.borders.size400.toDouble()),
  );
  static final BorderRadius l = BorderRadius.all(
    Radius.circular(rawProperties.borders.size500.toDouble()),
  );
  static final BorderRadius xl = BorderRadius.all(
    Radius.circular(rawProperties.borders.size600.toDouble()),
  );
}
