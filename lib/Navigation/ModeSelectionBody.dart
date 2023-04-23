import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet2cp/Navigation/Body.dart';
import 'package:projet2cp/Navigation/Mode.dart';

class ModeSelectionBody extends Body {

  final Function(Mode)? onModeSelected;


  ModeSelectionBody({Key? key, this.onModeSelected, super.lastScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {




    return
      MaterialApp(
        theme: ThemeData().copyWith(
      colorScheme: ThemeData().colorScheme.copyWith(primary: Colors.green),
      ),
      home: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
          ],
        ),
        ),
      );
  }

}


class _Body extends StatefulWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
