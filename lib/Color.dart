import 'dart:ui';
import 'package:flutter/painting.dart' as p;

enum Color {

  oceanBlueDark(color: p.Color(0xff19806D)),
  oceanBlue(color: p.Color(0xff25BEA1)),
  goldenYellowDark(color: p.Color(0xffB29200)),
  goldenYellow(color: p.Color(0xffE5BC00)),
  terraCottaRedDark(color: p.Color(0xffDC5C3C)),
  terraCottaRed(color: p.Color(0xffE06E52)),
  orange(color: p.Color(0xffEB8914)),
  denimBlue(color: p.Color(0xff81B0FE)),
  yellowGreenDark(color: p.Color(0xff6E9D2F )),
  yellowGreen(color: p.Color(0xff8CC63F )),
  yellowGreenLigh(color: p.Color(0xff86B14E )),
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