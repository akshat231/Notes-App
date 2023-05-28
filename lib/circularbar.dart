import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

Future<dynamic> circularmethod(context, value) {
  return showDialog(
      context: context,
      builder: (context) {
        return Visibility(
            visible: value, child: Center(child: CircularProgressIndicator()));
      });
}
