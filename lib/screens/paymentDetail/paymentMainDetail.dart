import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/header.dart';
import 'package:fabtech_aspirationclass_dev/screens/paymentDetail/dues/dueTab.dart';


class PaymentMainDetail extends StatefulWidget {
  final String studentId,studentName,facultyId,subject;
  PaymentMainDetail({this.studentName,this.studentId,this.facultyId,this.subject});
  @override
  _PaymentMainDetailState createState() => _PaymentMainDetailState();
}

class _PaymentMainDetailState extends State<PaymentMainDetail> {
  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, 'Payments'),
      body: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          backgroundColor: Colors.teal.shade100,
          currentIndex: _pageIndex,
          activeColor: Colors.purple,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment_late),
              label: 'Dues',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment_turned_in),
              label: 'Paid',
            ),
          ],
        ),
        tabBuilder: (context,index){
          if(index == 0) {
            return CupertinoTabView(
              builder: (BuildContext context) => DueTab(facultyId: widget.facultyId,subject: widget.subject,
              studentId: widget.studentId,studentName: widget.studentName),
            );
          } else {

            return  CupertinoTabView(
              builder: (BuildContext context) => DueTab(facultyId: widget.facultyId,subject: widget.subject,
                  studentId: widget.studentId,studentName: widget.studentName),
            );
          }
        },
      ),
    );
  }
}