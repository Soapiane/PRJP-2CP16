import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet2cp/Authentication/AvatarSelectionBody.dart';
import 'package:projet2cp/Color.dart' as color;
import 'package:projet2cp/Generator.dart';
import 'package:projet2cp/Info/User.dart';
import 'package:projet2cp/Navigation/Profile/Profile.dart';

class ChangeAvatar extends StatelessWidget {
  const ChangeAvatar({Key? key}) : super(key: key);

  static const double borderRadius = 20;

  @override
  Widget build(BuildContext context) {

    Generator generator = Generator(context: context);
    double width = generator.calculateX(generator.deviceWidth*3/4);
    double height = generator.calculateY(generator.deviceHeight - 100);



    return Center(
      child: SizedBox(
        width: width,
        height: height,
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                color: color.Color.yellowGreen.color,
              ),
              child: AvatarSelectionBody(onFinally: (){
                Navigator.pop(context);
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (context) => Profile(),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }




}
