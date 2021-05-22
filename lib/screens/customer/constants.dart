import 'package:flutter/material.dart';

InputDecoration textFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
  labelStyle: TextStyle(
    fontSize: 16,
    color: Colors.purple,
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.purple, width: 1),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.purple, width: 1),
  ),
  border:
      OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
);

TextStyle labelS = TextStyle(
  fontWeight: FontWeight.w600,
  fontSize: 14,
);

TextStyle unSelectedLabelS = TextStyle(
  fontWeight: FontWeight.w400,
  fontSize: 14,
);
