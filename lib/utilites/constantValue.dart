import 'package:flutter/material.dart';

const kRootlink = "http://192.168.0.100/AspirationClasses/";
const kRegisterUser = 'registration.php';
const kDeleteRegRequest = 'deleteRegReqst.php';
const kSignIn = 'signIn.php';
const kSelectClass = 'selectClass.php';
const kClassSelectStudent = 'selectClassStudents.php';
const kClassSelectFaculty = 'selectClassFaculty.php';
const kClassSelectFacultyStd = 'selectFacultyStudents.php';
const kSelectStudentPersonalDetails = 'selectStudentPersonalDetails.php';



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

const inputStudentNameDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  hintText: 'Enter Student Name',
  hintStyle: TextStyle(fontSize: 12,),
  prefixIcon: Icon(Icons.supervised_user_circle_sharp),
  border: OutlineInputBorder(
    borderRadius:
    BorderRadius.all(Radius.circular(25),
    ),
    borderSide:
    BorderSide(width: 3,color: Colors.redAccent,style: BorderStyle.solid),
  ),
);

const inputFacultyNameDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  hintText: 'Enter Faculty Name',
  hintStyle: TextStyle(fontSize: 12,),
  prefixIcon: Icon(Icons.assignment_ind),
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

const secondaryHeadingTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 35,
  fontFamily: 'yellowRabbit',
);

const primaryHeadingTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 25,
  fontFamily: 'LemonMilkBold',
);


