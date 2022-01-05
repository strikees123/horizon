// @dart=2.9
import 'package:flutter/material.dart';

AppBar appBarMain(BuildContext context){
  return AppBar(
    title: Text("",
      style: TextStyle(color: Colors.white,fontStyle: FontStyle.italic,),
    ),
  );
}

InputDecoration textField(String text){
  return InputDecoration(
    hintText: text,
  );
}