import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:projet2cp/Color.dart' as color;
import 'package:projet2cp/TextGenerator.dart';

class Loading extends StatefulWidget {

  static bool isLoading = false;
  bool progressBar;
  late _LoadingState state;

  Loading({Key? key, String? text, required this.progressBar}) : super(key: key){
    state = _LoadingState(progressBar: progressBar);
  }

  static Loading ShowLoading(BuildContext context, {String? text, bool progressBar = false}){
    Loading loading = Loading(text: text, progressBar: progressBar,);
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return loading;
      },
    );
    isLoading = true;
    return loading;
  }

  static void HideLoading(BuildContext context){
    if (isLoading) Navigator.of(context).pop();
    isLoading = false;
  }

  void updateProgress(double newValue){
    state.updateProgress(newValue);
  }

  @override
  State<Loading> createState() {
    return state;
  }
}

class _LoadingState extends State<Loading> {


  String? text;
  bool progressBar;
  double progress = 0;
  _LoadingState({Key? key, this.text, required this.progressBar});


  void updateProgress(double newValue){
    setState(() {
      progress = newValue;
    });
  }


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
              progressBar
                  ? Padding(
                    padding:  EdgeInsets.only(top: textGenerator.calculateY(20)),
                    child: SizedBox(
                      width: textGenerator.calculateX(170),
                      child: LinearProgressIndicator(
                        backgroundColor: color.Color.yellowGreenDark.color,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        value: progress,
                      ),
                    ),
                  )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
