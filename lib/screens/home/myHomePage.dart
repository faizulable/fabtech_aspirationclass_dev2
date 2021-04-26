import 'package:flutter/material.dart';
import 'package:fabtech_aspirationclass_dev/main.dart';
import 'package:fabtech_aspirationclass_dev/models/appPref.dart';
import 'package:fabtech_aspirationclass_dev/customPainter/LabelCustomPainter.dart';
import 'package:fabtech_aspirationclass_dev/screens/home/gridWidget.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/header.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  List<ClassList> classList;

  @override
  void initState() {
    super.initState();
    classList =[];
    classList.add(ClassList('5','50'));
    classList.add(ClassList('6','35'));
    classList.add(ClassList('7','40'));
    classList.add(ClassList('8','53'));
    classList.add(ClassList('9','45'));
    classList.add(ClassList('10','60'));
    classList.add(ClassList('11','87'));
    classList.add(ClassList('12','69'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, 'Branch'),
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
                                child: Text(sp.getString(AppPref.centerNamePref),
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
                                child: Text(sp.getString(AppPref.emailPref),
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
              child: CustomPaint(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Text('List of classes',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontFamily: 'Overtaking',
                      ),
                    ),
                  ),
                ),
                painter: RPSCustomPainter(),
              ),
            ),
            Expanded(
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2
                  ),
                  itemCount: classList.length,
                  itemBuilder: (BuildContext context, int index){
                      return GestureDetector(
                        child: GridWidget(classNum: classList[index].classNum,
                            numOfStudents: classList[index].numOfStudents),
                        onTap: (){
                          print('class is pressed');
                        },
                      );
                  },
              ),
            ),
          ],
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class ClassList
{
  final String classNum,numOfStudents;
  ClassList(this.classNum,this.numOfStudents);
}