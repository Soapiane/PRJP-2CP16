import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet2cp/Generator.dart';


class ProgressBar extends StatelessWidget {

  final int total, filled;
  final Size size;
  late double borderWidth;

  ProgressBar({super.key,  required this.total, required this.size, this.filled = 0});


  List<Widget> generateBars(){



    List<Widget> bars = [];
    for(int i = 0; i < total; i++){
      bars.add(Expanded(
          child: Container(
        height: size.height,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          gradient: i < filled ? const LinearGradient(
            colors: [
              Color(0xff2A2A72),
              Color(0xff009ffd),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ) : null,
          borderRadius:
                i == 0 ?
          BorderRadius.only(topLeft: Radius.circular(1000), bottomLeft: Radius.circular(1000))
              : i == total - 1 ?
          BorderRadius.only(topRight: Radius.circular(1000), bottomRight: Radius.circular(1000))
              : null,
        ),
      )
      ));
      if(i < total - 1){
        bars.add( VerticalDivider(
          color: Colors.white,
          thickness: borderWidth,
          width: borderWidth,
        ));
      }
    }
    return bars;
  }
  
  @override
  Widget build(BuildContext context) {


    borderWidth = size.width * 2 / 500;




    return Row(
      children: [
        SizedBox(
          height: size.height,
          width: size.width,
          child: Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(1000),
            color: Colors.transparent,
            child: Container(
              height: size.height,
              width: size.width,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                color:  Color(0xff5A5A5A),
                borderRadius: BorderRadius.circular(1000),
                border: Border.all(color: Colors.white, width: borderWidth),
              ),
              child: Stack(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: generateBars(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: size.height/8),
                    child: Container(
                      width: size.width,
                      height: size.height/8,
                      decoration: const BoxDecoration(
                        color: Color(0x7fffffff),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

}
