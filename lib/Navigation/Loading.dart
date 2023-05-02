import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:projet2cp/Color.dart' as color;
import 'package:projet2cp/TextGenerator.dart';

class Loading extends StatelessWidget {

  static bool isLoading = false;
  String? text;

  static void ShowLoading(BuildContext context, {String? text}){
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Loading(text: text,);
      },
    );
    isLoading = true;
  }
  static void HideLoading(BuildContext context){
    if (isLoading) Navigator.of(context).pop();
    isLoading = false;
  }

  Loading({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextGenerator textGenerator = TextGenerator(context: context);
    return Center(
      child: Material(
        elevation: 10,
        color: color.Color.yellowGreen.color,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: LoadingAnimationWidget.hexagonDots(color: Colors.white, size: 30,),
                  ),
                  textGenerator.generateTextView(texts: [text != null ? text! : "Chargement..."], fontSize: 16 ).first,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
