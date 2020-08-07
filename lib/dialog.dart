import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogsCreator {
  Future<String> createDialog(BuildContext context,String title
  , List<Widget> newactions,Widget contents)
  {
    return showDialog(
      context: context,
      builder: (context)
        {
          return AlertDialog(
            title: Text(title),
            actions: newactions,
            content: contents,);
        }
      );
  }
}