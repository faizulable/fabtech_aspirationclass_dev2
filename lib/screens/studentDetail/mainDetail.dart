import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/header.dart';
import 'package:fabtech_aspirationclass_dev/screens/studentDetail/personal/personalTab.dart';
import 'package:fabtech_aspirationclass_dev/screens/studentDetail/subject/subjectTab.dart';

class MainDetail extends StatefulWidget {
  final String studentId,studentName,studentClass;
  MainDetail({this.studentName,this.studentId,this.studentClass});
  @override
  _MainDetailState createState() => _MainDetailState();
}

class _MainDetailState extends State<MainDetail> {
  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, 'Details'),
      body: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          backgroundColor: Colors.teal.shade100,
          currentIndex: _pageIndex,
          activeColor: Colors.purple,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment_ind),
              label: 'Personal',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Subject',
            ),
          ],
        ),
        tabBuilder: (context,index){
          if(index == 0) {
            return  CupertinoTabView(
              builder: (BuildContext context) => PersonalTab(classNumStr: widget.studentClass,
                studentIdStr: widget.studentId,studnetNameStr: widget.studentName,),
            );
          } else {
            return CupertinoTabView(
              builder: (BuildContext context) => SubjectTab(),
            );
          }
        },
      ),
    );
  }
}