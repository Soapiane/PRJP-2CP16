import 'dart:ui';
import 'package:flutter/painting.dart' as p;

enum Color {

  denimBlue(color: p.Color(0xff81B0FE)),
  yellowGreen(color: p.Color(0xff8CC63F )),
  bangladeshGreen(color: p.Color(0xff04724D )),
  blackOlive(color: p.Color(0xff404040)),
  black(color: p.Color(0xff000000)),
  grey(color: p.Color(0x66000000)),
  brown(color: p.Color(0xff755959)),
  white(color: p.Color(0xffffffff)),
  whiteFront(color: p.Color(0xfffafafa)),
  blue(color: p.Color(0xff48beff)),
  yellow(color: p.Color(0xffDDE108)),
  transparent(color: p.Color(0x00000000));



  final p.Color color;


  const Color({
    required this.color,
  });





}