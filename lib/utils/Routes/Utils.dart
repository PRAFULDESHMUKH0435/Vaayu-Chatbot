import 'package:flutter/material.dart';

class Utils{
  static showsnackbar(BuildContext context,String message, Color color){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: color,
        content: Text(message)));
  }
}