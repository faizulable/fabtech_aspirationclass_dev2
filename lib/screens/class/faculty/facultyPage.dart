import 'package:flutter/material.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/header.dart';

class FacultyPage extends StatefulWidget {
  @override
  _FacultyPageState createState() => _FacultyPageState();
}

class _FacultyPageState extends State<FacultyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, 'Class Faculty'),
      body: Container(
        child: Text('FacultyPage'),
      ),
    );
  }
}
