import 'package:flutter/material.dart';

InputDecoration detailsDecoration = InputDecoration(
  contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
  hintStyle: TextStyle(
    fontSize: 13,
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
