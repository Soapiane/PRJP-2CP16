import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet2cp/Avatar.dart';
import 'package:projet2cp/Body.dart';
import 'package:projet2cp/ButtonGenerator.dart';
import 'package:projet2cp/Color.dart' as color;
import 'package:projet2cp/Generator.dart';
import 'package:projet2cp/Margin.dart';
import 'package:projet2cp/Repository/DatabaseRepository.dart';
import 'package:projet2cp/TextGenerator.dart';
import 'package:projet2cp/User.dart';

class AvatarSelectionBody extends Body {

  final Function onFinally;

  AvatarSelectionBody({Key? key, required this.onFinally});

  @override
  Widget build(BuildContext context) {
    return _AvatarSelectionBody(onFinally: onFinally);
  }

}


class _AvatarSelectionBody extends StatefulWidget {

  final Function onFinally;

  const _AvatarSelectionBody({Key? key, required this.onFinally}) : super(key: key);

  @override
  State<_AvatarSelectionBody> createState() => _AvatarSelectionBodyState();
}

class _AvatarSelectionBodyState extends State<_AvatarSelectionBody> {

  int _selectedIndex = 0;
  late List<Padding> _rows;



  @override
  Widget build(BuildContext context) {


    TextGenerator textGenerator = TextGenerator(context: context);
    ButtonGenerator buttonGenerator = ButtonGenerator(context: context);

    _rows = [];

    int index = 0;
    List<_AvatarButton> buttons = [];
    for (int i = 0; i<2; i++){
      buttons = [];
      for (int j = 0; j<5; j++){
        buttons.add(_AvatarButton(
          selected: index == _selectedIndex,
          index: index,
          onTap: (index){
            setState(() {
              print("CLICKED $index");
              _selectedIndex = index;
            });
          },
        ));
        index++;
      }
      _rows.add(
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: buttons,
            ),
          ),
        );

    }

    return
      MaterialApp(
        theme: ThemeData().copyWith(
          colorScheme: ThemeData().colorScheme.copyWith(
              primary: Colors.green,
          ),
        ),
        home: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Center(
            child: Column(
              children: [
                textGenerator.generateTextView(
                  texts: ["Choisissez un avatar"],
                  color: color.Color.blackOlive,
                  fontSize: 16,
                ).first,
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    width: Generator(context: context).deviceWidth - Generator(context: context).calculateX(2*183),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: _rows,
                    ),
                  ),
                ),

                buttonGenerator.generateTextButton(
                  height: 45,
                  width: 250,
                  text: "Continuer",
                  margin: Margin(
                    top: 30,
                    context: context,
                  ),
                  backgroundColor: color.Color.yellow,
                  textColor: color.Color.white,
                  onTap: (){
                    _onFinally();
                  },
                ).first,
              ],
            ),
          ),
        ),
      );
  }

  Future<void> _onFinally() async {
    User().setAvatar(Avatar.values[_selectedIndex]);
    DatabaseRepository().uploadUserInfo();
    widget.onFinally.call();
  }

  
}

class _AvatarButton extends StatelessWidget {
  
  final bool selected;
  final int index;
  final Function(int) onTap;
  
  _AvatarButton({required this.selected, required this.index, required this.onTap});
  
  @override
  Widget build(BuildContext context) {
    
    ButtonGenerator buttonGenerator = ButtonGenerator(context: context);
    
    return buttonGenerator.generateImageButtom(
      height: 55,
      width: 55,
      imagePath: "assets/avatars/avatar0.png",
      backgroundColor: selected ? color.Color.bangladeshGreen : color.Color.white,
      borderRadius: BorderRadius.circular(13),
      onTap: (){
        onTap.call(index);
      },
    );
  }
  
}

