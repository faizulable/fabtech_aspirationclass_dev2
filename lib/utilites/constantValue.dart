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

const inputNameDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  hintText: 'Enter Name',
  hintStyle: TextStyle(fontSize: 12,),
  prefixIcon: Icon(Icons.location_city),
  border: OutlineInputBorder(
    borderRadius:
    BorderRadius.all(Radius.circular(25),
    ),
    borderSide:
    BorderSide(width: 3,color: Colors.redAccent,style: BorderStyle.solid),
  ),
);

const inputAddressDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  hintText: 'Enter Address',
  hintStyle: TextStyle(fontSize: 12,),
  prefixIcon: Icon(Icons.location_pin),
  border: OutlineInputBorder(
    borderRadius:
    BorderRadius.all(Radius.circular(25),
    ),
    borderSide:
    BorderSide(width: 3,color: Colors.redAccent,style: BorderStyle.solid),
  ),
);

const inputContactDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  hintText: 'Enter Contact Number',
  hintStyle: TextStyle(fontSize: 12,),
  prefixIcon: Icon(Icons.phone),
  border: OutlineInputBorder(
    borderRadius:
    BorderRadius.all(Radius.circular(25),
    ),
    borderSide:
    BorderSide(width: 3,color: Colors.redAccent,style: BorderStyle.solid),
  ),
);