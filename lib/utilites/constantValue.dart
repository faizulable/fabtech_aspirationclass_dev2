import 'package:flutter/material.dart';

const inputEmailDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  hintText: 'Enter Email ID',
  hintStyle: TextStyle(fontSize: 12,),
  prefixIcon: Icon(Icons.email),
  border: OutlineInputBorder(
    borderRadius:
    BorderRadius.all(Radius.circular(25),
    ),
    borderSide:
    BorderSide(width: 3,color: Colors.redAccent,style: BorderStyle.solid),
  ),
);

const inputPasswordDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  hintText: 'Enter Password',
  hintStyle: TextStyle(fontSize: 12,),
  prefixIcon: Icon(Icons.lock),
  border: OutlineInputBorder(
    borderRadius:
    BorderRadius.all(Radius.circular(25),
    ),
    borderSide:
    BorderSide(width: 3,color: Colors.redAccent,style: BorderStyle.solid),
  ),
);