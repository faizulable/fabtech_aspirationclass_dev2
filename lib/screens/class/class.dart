import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'student/studentPage.dart';
import 'faculty/facultyPage.dart';

class ClassPage extends StatefulWidget {
  final String classNum;
  ClassPage({this.classNum});
  @override
  _ClassPageState createState() => _ClassPageState();
}

class _ClassPageState extends State<ClassPage> {
  PageController _pageController;
  int _pageIndex = 0;


  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  onPageChange(int pageIndex){
    setState(() {
      _pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex){
    _pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          StudentPage(classNum: widget.classNum),
          FacultyPage(),
        ],
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: onPageChange,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Colors.teal.shade100,
        currentIndex: _pageIndex,
        onTap: onTap,
        activeColor: Colors.purple,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle_sharp),
            label: 'Students',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_ind),
            label: 'Faculty',
          ),
        ],
      ),
    );
  }
}
