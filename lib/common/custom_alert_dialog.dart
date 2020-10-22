import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:single_sign_in_firestore/domain/entities/error_dto.dart';
import 'package:single_sign_in_firestore/presentation/widgets/primary_button_solid.dart';

class CustomAlertDialog {
  var _context;

  CustomAlertDialog(BuildContext context) {
    _context = context;
  }

  void showErrorAlert(ErrorEntity data, [Function clickCallback]) {
    showDialog(
      context: _context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("${data.message ?? "Error"}"),
          content: new Text("${data.description ?? ""}"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                if (clickCallback is Function) {
                  clickCallback();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void showRegisterAlert(
      Function clickCallback,[String message = "You haven't registered yet.\nDo you want to register now?",
      ]) {
    showDialog(
      context: _context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(""),
          content: new Text("${message ?? ""}"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();

              },
            ),
            PrimarySmall("Yes", () {
              Navigator.of(context).pop();
              clickCallback();
            }),
          ],
        );
      },
    );
  }

  void showSureAlert(
      Function clickCallback,[String message = "Are you sure you want to delete?",
      ]) {
    showDialog(
      context: _context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Delete"),
          content: new Text("${message ?? ""}"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();

              },
            ),
            PrimarySmall("Confirm", () {
              Navigator.of(context).pop();
              clickCallback();
            }),
          ],
        );
      },
    );
  }
}