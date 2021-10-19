import 'package:flutter/cupertino.dart';

class DialogUtils{
  static showDialog(BuildContext cxt, String title, String content, ok(), cancel()) {
    showCupertinoDialog<int>(
        context: cxt,
        builder: (cxt) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text("OK"),
                onPressed: () {
                  ok();
                },
              ),
              CupertinoDialogAction(
                child: Text("Cancel"),
                onPressed: () {
                  cancel();
                },
              )
            ],
          );
        });
  }

  static showOneDialog(BuildContext cxt, String title, String content, ok()) {
    showCupertinoDialog<int>(
        context: cxt,
        builder: (cxt) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text("OK"),
                onPressed: () {
                  ok();
                },
              )
            ],
          );
        });
  }
}