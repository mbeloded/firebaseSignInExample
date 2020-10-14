import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {

  final String title;
  final Function clickCallback;
  final Color titleColor;
  final Color bgColor;
  final Color borderColor;
  final Color highlightColor;
  final Color splashColor;
  final double radius;

  SignInButton({
    this.title,
    this.clickCallback,
    this.titleColor = Colors.grey,
    this.bgColor = Colors.white,
    this.borderColor = Colors.blue,
    this.highlightColor,
    this.splashColor = Colors.grey,
    this.radius = 4
  });

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      splashColor: splashColor,
      onPressed: () {
        clickCallback();
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      highlightElevation: 0,
      borderSide: BorderSide(color: borderColor),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("images/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  color: titleColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}