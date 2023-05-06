
import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:projet2cp/ButtonGenerator.dart';
import 'package:projet2cp/Couple.dart';
import 'package:projet2cp/Generator.dart';
import 'package:projet2cp/Margin.dart';
import 'package:projet2cp/Color.dart' as color;
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svg_provider;
import 'package:projet2cp/main.dart' as main;

class TextGenerator extends Generator {
  TextGenerator({required super.context});

  Couple generateTextView({
    double? xPos,
    double? yPos,
    required List<String> texts,
    List<Function>? onSpansTap,
    double fontSize = 20,
    String fontFamily = 'AndikaNewBasicBold',
    color.Color color = color.Color.white,
    TextStyle? textStyle,
    TextStyle? linkStyle,
  }){


    TextSpan textView = TextSpan();
    onSpansTap??=[];
    textStyle ??= TextStyle(
      color: color.color,
      fontFamily: fontFamily,
      fontSize: fontSize,
    );
    linkStyle ??= TextStyle(
      color: color.color,
      fontSize: fontSize,
      fontFamily: fontFamily,
      decoration: TextDecoration.underline,
    );

    List<TextSpan> textsSpan = [];

    GestureRecognizer? onSpanTapRecognizer;

    int j=0;
    for (int i=0;i<texts.length;i++){

      onSpanTapRecognizer = null;
      if (j<onSpansTap.length) {
        Function onSpanTap = onSpansTap[j];
        onSpanTapRecognizer = TapGestureRecognizer()
        ..onTap = () {
          onSpanTap.call();
        };
      }

      TextSpan textSpan;

      if (i%2 == 0) {
        textSpan = TextSpan(
          text: texts[i],
        );

        textsSpan.add(
          TextSpan(
            text: texts[i],
          ),
        );

        if (i==0) textView = textSpan;
      } else {
        textsSpan.add(
          TextSpan(
            text: texts[i],
            style: linkStyle,
            recognizer: onSpanTapRecognizer,
          ),
        );
        j++;
      }
    }




    Widget textWidget = DefaultTextStyle(
      textAlign: TextAlign.center,
      style: textStyle,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: textStyle,
          children: textsSpan,
        ),
      ),
    );

    if (xPos != null || yPos != null){


      Vector2 coords = calculateXY(xPos, yPos);



      return Couple( Positioned(
        left: coords.x,
        top:  coords.y,
        child: textWidget,
      ), textView);
    }

    return Couple( textWidget,  textView);

  }

  Couple generateTextField({
    required double height,
    required double width,
    double? xPos,
    double? yPos,
    String hintText= "",
    double fontSize = 20,
    color.Color textColor = color.Color.grey,
    IconData? icon,
    double cornerRadius  = 50,
    Margin? margin,
    bool hide = false,
    String? rightButtonImagePath,
    double rightButtonPaddingVertical =0,
    double rightButtonPaddingHorizontal = 0,
    Function? onRightButtonPressed,
  }){

    ButtonGenerator buttonGenerator = ButtonGenerator(context: context);

    Vector2 dims = calculateXY(width, height);
    double rightButtonDim = 0;


    icon ??= Icons.person;
    margin??=Margin(context: super.context);

    final myController = TextEditingController();
    final FocusNode focusNode = FocusNode();
    focusNode.addListener(() {
      main.setLandscapeMode();
    });
    TextField textField = TextField(
      onTap: () {
        focusNode.requestFocus();
        main.setLandscapeMode();
      },
      focusNode: focusNode,
      controller: myController,
      autofillHints: const [],
      obscureText: hide,
      enableSuggestions: false,
      autocorrect: false,
      style: TextStyle(
        fontFamily: "PoppinsRegular",
        fontSize: fontSize,
        color: color.Color.black.color,
      ),
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(0),
        alignLabelWithHint: true,
        prefixIcon: Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Icon(
            icon,
          ),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          fontFamily: "PoppinsRegular",
          fontSize: fontSize,
          color: textColor.color,
        ),
        border: InputBorder.none,
      ),
    );


    Widget showPasswordBtn = const SizedBox.shrink();
    if (rightButtonImagePath != null) {
      rightButtonDim = dims.y / 2;
      showPasswordBtn = buttonGenerator.generateImageButtom(
          height: rightButtonDim,
          width: rightButtonDim,
          imagePath: rightButtonImagePath,
          paddingHorizontal: rightButtonPaddingHorizontal,
          paddingVertical: rightButtonPaddingVertical,
          borderRadius: BorderRadius.circular(cornerRadius),
          backgroundColor: color.Color.whiteFront,
          elevation: 0,
      );
    }

    return
      Couple(Container(
      margin: EdgeInsets.fromLTRB(margin.left, margin.top , margin.right, margin.bottom),
      width: dims.x,
      height: dims.y,
      // padding: const EdgeInsets.fromLTRB(10, 0, 0, 0,),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: color.Color.white.color,
        borderRadius: BorderRadius.circular(cornerRadius),
      ),
      child: Material(
        borderRadius: BorderRadius.circular(cornerRadius),
        elevation: 3,
        child: Row(
          mainAxisSize: MainAxisSize.max,

          children: [
            Container(
              height: dims.y,
              width: dims.x - rightButtonDim-rightButtonPaddingHorizontal*2-10,
              child: textField,
            ),
            showPasswordBtn,
          ],
        ),
      ),
      ),
        textField,
    );
  }


}