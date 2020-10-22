import 'package:flutter/material.dart';

class PrimarySmall extends StatefulWidget {
  final String title;
  final Function clickCallback;

  PrimarySmall(this.title, this.clickCallback);

  @override
  _PrimarySmallState createState() => _PrimarySmallState();
}

class _PrimarySmallState extends State<PrimarySmall> {

  final _textStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontFamily: 'SFProDisplay',
      letterSpacing: 0.6,
      fontSize: 16);

  @override
  Widget build(BuildContext context) {

    return RawMaterialButton(
      onPressed: (){
        widget.clickCallback();
      },
      padding: EdgeInsets.symmetric(
          horizontal: 38.0, vertical: 12.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0)
      ),
      fillColor: Colors.green, //specify background color for the button here
      highlightColor: Colors.lightGreen, //color when the button is being actively pressed, quickly fills the button and fades out after
      child: Text(widget.title, style: _textStyle),
    );
  }
}