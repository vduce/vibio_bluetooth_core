import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class ToastUtils{

   static showToast(String content){
     Fluttertoast.showToast(
         msg: content,
         toastLength: Toast.LENGTH_LONG,
         gravity: ToastGravity.CENTER,
         timeInSecForIosWeb: 1,
         backgroundColor: Colors.black54,
         textColor: Colors.blue,
         fontSize: 16.0
     );
   }
}