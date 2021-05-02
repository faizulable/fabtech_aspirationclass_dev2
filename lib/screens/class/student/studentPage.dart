import 'package:flutter/material.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/header.dart';
import 'package:fabtech_aspirationclass_dev/models/appPref.dart';
import 'package:fabtech_aspirationclass_dev/main.dart';
import 'package:fabtech_aspirationclass_dev/utilites/constantValue.dart';
import 'package:fabtech_aspirationclass_dev/screens/class/student/listWidget.dart';

class StudentPage extends StatefulWidget {
  final String classNum;
  StudentPage({this.classNum});
  @override
  _StudentPageState createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  List<StudentList> studentList;

  @override
  void initState() {
    super.initState();
    studentList =[];
    studentList.add(StudentList('AAAAAA0521', 'Md Inzamamul Haque', 'M', '7894561230', 'dummyId@gmail.com',
        '2', '600', '0'));
    studentList.add(StudentList('BBBBBB0521', 'Md Faizul Haque', 'M', '7894561230', 'dummyId@gmail.com',
        '2', '600', '0'));
    studentList.add(StudentList('CCCCCC0521', 'Md Waizul Haque', 'M', '7894561230', 'dummyId@gmail.com',
        '2', '600', '600'));
    studentList.add(StudentList('DDDDDD0521', 'Aamir Saif', 'M', '7894561230', 'dummyId@gmail.com',
        '2', '600', '0'));
    studentList.add(StudentList('EEEEEE0521', 'Mohd Nadeem Ather', 'M', '7894561230', 'dummyId@gmail.com',
        '2', '600', '1200'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, 'Student'),
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
            Container(
              margin: EdgeInsets.symmetric(vertical: 5,horizontal: 7),
              height: 110.0,
              decoration: BoxDecoration(
                color: Colors.teal.shade100,
                borderRadius: BorderRadius.all(Radius.circular(25)),
                shape: BoxShape.rectangle,
              ),
              child: SingleChildScrollView(
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5,horizontal: 5.0),
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          image: DecorationImage(
                              image: AssetImage('images/emblame.png'),
                              fit: BoxFit.fill
                          ),
                          shape: BoxShape.circle
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Center(
                                child: Text('CLASS ' + widget.classNum,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontFamily: 'LemonMilkBold',
                                  ),
                                ),
                              ),
                              width: 280.0,
                            ),
                            Container(
                              width: 250,
                              child: Center(
                                child: Text(sp.getString(AppPref.userNamePref),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'LandasansMedium',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
              child: Center(
                child: TextFormField(
                  decoration: inputStudentNameDecoration,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: studentList.length,
                  itemBuilder: (BuildContext context, int index){
                    return ListWidget(studentId: studentList[index].studentId,name: studentList[index].name,
                    contact: studentList[index].contact,monthlyfees: studentList[index].monthlyfees,
                      dues: studentList[index].dues);
                  },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StudentList
{
  final String studentId,name,gender,contact,emailId,subjectCount,monthlyfees,dues;
  StudentList(this.studentId,this.name,this.gender,this.contact,
      this.emailId,this.subjectCount,this.monthlyfees,this.dues);
}