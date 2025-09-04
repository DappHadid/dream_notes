import 'package:flutter/material.dart';

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  hintStyle: TextStyle(color: Colors.grey),
  contentPadding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 20.0),
  filled: true,
  fillColor: Colors.white70, // Disesuaikan dengan contoh Anda
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.transparent, width: 1.5),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Color(0xFFE8BF36),
      width: 2.0,
    ), // Warna disesuaikan
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
);
