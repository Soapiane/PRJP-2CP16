import 'package:flutter/cupertino.dart';
import 'package:projet2cp/Generator.dart';

class Margin {
  //a class the encapsulates the margin properties

  double? _left, _top, _right, _bottom;
  BuildContext context;
  late Generator generator;

  Margin({double left = 0,double  top = 0, double right = 0,double bottom = 0, required this.context}){

    generator = Generator(context: context);

    this.left = left;
    this.top = top;
    this.right = right;
    this.bottom = bottom;

  }

  get bottom => _bottom;

  set bottom(value) {
    _bottom = generator.calculateY(value);
  }

  get right => _right;

  set right(value) {
    _right = generator.calculateX(value);
  }

  get top => _top;

  set top(value) {
    _top = generator.calculateY(value);
  }

  get left => _left;

  set left( value) {
    _left = generator.calculateX(value);
  }
}