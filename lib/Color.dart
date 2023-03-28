import 'dart:ui';
import 'package:flutter/painting.dart' as p;

enum Color {
  brown(color: p.Color(0xff755959)),
  white(color: p.Color(0xffffffff)),
  blue(color: p.Color(0xff48beff)),
  yellow(color: p.Color(0xffDDE108)),
  transparent(color: p.Color(0x00ffffff));



  final p.Color color;


  const Color({
    required this.color,
  });





}