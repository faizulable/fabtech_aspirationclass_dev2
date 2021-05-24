import 'package:flutter/material.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/header.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/topHeadline.dart';
import 'package:fabtech_aspirationclass_dev/models/addStudent.dart';

class AddPageTwo extends StatefulWidget {
  final AddStudentPersonalDetails addstudentPerDtls;
  AddPageTwo({this.addstudentPerDtls});
  @override
  _AddPageTwoState createState() => _AddPageTwoState();
}

class _AddPageTwoState extends State<AddPageTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, 'ADD STUDENT'),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.deepPurple.shade600, Colors.teal.shade400]
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            topContainer(widget.addstudentPerDtls.name,'CLASS '+widget.addstudentPerDtls.classNum),
          ],
        ),
      ),
    );
  }
}
