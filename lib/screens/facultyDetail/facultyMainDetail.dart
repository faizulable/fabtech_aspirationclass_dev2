import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/header.dart';
import 'package:fabtech_aspirationclass_dev/screens/facultyDetail/facultyStudents/facultyStudentPage.dart';
import 'package:fabtech_aspirationclass_dev/screens/facultyDetail/facultyPaid/facultyPaidTab.dart';
import 'package:fabtech_aspirationclass_dev/screens/facultyDetail/facultyDues/facultyDueTab.dart';

class FacultyMainDetail extends StatefulWidget {
  final String classNum,subject,facultyName,facultyId;
  FacultyMainDetail({this.classNum,this.subject,this.facultyName,this.facultyId});
  @override
  _FacultyMainDetailState createState() => _FacultyMainDetailState();
}

class _FacultyMainDetailState extends State<FacultyMainDetail> {
  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, widget.subject),
      resizeToAvoidBottomInset: false,
      body: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          backgroundColor: Colors.teal.shade100,
          currentIndex: _pageIndex,
          activeColor: Colors.purple,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle_sharp),
              label: 'Student',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment_turned_in),
              label: 'Paid',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment_late),
              label: 'Dues',
            ),
          ],
        ),
        tabBuilder: (context,index){
          if(index == 0) {
            return CupertinoTabView(
              builder: (BuildContext context) => FacultyStudentPage(classNum: widget.classNum,subject: widget.subject,
              facultyId: widget.facultyId,facultyName: widget.facultyName),
            );
          } else if (index == 1){
            return  CupertinoTabView(
              builder: (BuildContext context) => FacultyPaidTab(classNum: widget.classNum,subject: widget.subject,
                  facultyId: widget.facultyId,facultyName: widget.facultyName),
            );
          } else {
            return  CupertinoTabView(
              builder: (BuildContext context) => FacultyDueTab(classNum: widget.classNum,subject: widget.subject,
                  facultyId: widget.facultyId,facultyName: widget.facultyName),
            );
          }
        },
      ),
    );
  }
}