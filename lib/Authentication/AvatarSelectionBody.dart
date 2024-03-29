import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:projet2cp/Info/Avatar.dart';
import 'package:projet2cp/Navigation/Body.dart';
import 'package:projet2cp/ButtonGenerator.dart';
import 'package:projet2cp/Color.dart' as color;
import 'package:projet2cp/Generator.dart';
import 'package:projet2cp/Margin.dart';
import 'package:projet2cp/Navigation/Loading.dart';
import 'package:projet2cp/Repository/DatabaseRepository.dart';
import 'package:projet2cp/TextGenerator.dart';
import 'package:projet2cp/Info/User.dart' as user;

class AvatarSelectionBody extends Body {

  final Function onFinally;

  AvatarSelectionBody({Key? key, required this.onFinally}) : super(key: key);

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
  void initState() {
    super.initState();
    _selectedIndex = user.User().avatar.index;
  }



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
        debugShowCheckedModeBanner: false,
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
    //saves avatar in local storage
    user.User().setAvatar(Avatar.values[_selectedIndex]);
    Loading.ShowLoading(context);
    bool result = await InternetConnectionChecker().hasConnection;
    //id there's internet, the avatar will be uploaded
    if (result) await DatabaseRepository().uploadUserInfo();
    Loading.HideLoading(context);
    //execute the function sent by MainScreen
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
      imagePath: Avatar.values[index].getImagePath(),
      backgroundColor: selected ? color.Color.bangladeshGreen : color.Color.white,
      borderRadius: BorderRadius.circular(13),
      onTap: (){
        onTap.call(index);
      },
    );
  }
  
}

