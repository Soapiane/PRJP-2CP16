import 'dart:ui';
import 'package:flutter/painting.dart' as p;

enum Color {
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