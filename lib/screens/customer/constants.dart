import 'package:flutter/material.dart';

InputDecoration textFieldDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
  hintText: 'Email',
  hintStyle: TextStyle(
    fontSize: 13,
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0x99e4e4e4), width: 1),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 1),
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
