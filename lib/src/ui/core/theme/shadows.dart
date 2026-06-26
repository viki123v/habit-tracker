import 'package:flutter/painting.dart';

class ShadowPallette {
  static const List<BoxShadow> xs = [
    BoxShadow(blurRadius: 1),
    BoxShadow(blurRadius: 2)
  ];
  static const List<BoxShadow> s = [
    BoxShadow(blurRadius: 5, offset: Offset(0, 2)),
    BoxShadow(blurRadius: 2, offset: Offset(0, 0))
  ];
  static const List<BoxShadow> m = [ 
    BoxShadow(blurRadius: 9, offset: Offset(0,4)),
    BoxShadow(blurRadius: 2, offset: Offset(0,0))
  ];
  static const List<BoxShadow> l = [ 
    BoxShadow(blurRadius: 17,offset: Offset(0, 8)),
    BoxShadow(blurRadius: 2,offset: Offset(0, 0))
  ];
  static const List<BoxShadow> xl = [ 
    BoxShadow(blurRadius: 35, offset: Offset(0, 17)),
    BoxShadow(blurRadius: 2, offset: Offset(0, 0))
  ];
}
