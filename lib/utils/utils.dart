
import 'package:flutter/material.dart';

class Utils{
  void customMessage(BuildContext context, String message, Color background) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: background,
        ));
  }
}