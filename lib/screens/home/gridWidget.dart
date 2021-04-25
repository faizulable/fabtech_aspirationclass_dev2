import 'package:flutter/material.dart';

class GridWidget extends StatelessWidget {
  String classNum,numOfStudents;
  GridWidget({this.classNum,this.numOfStudents});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 10.0,
        shadowColor: Colors.purpleAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        color: Colors.teal.shade100,
        child: SizedBox(
          height: 200.0,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: CircleAvatar(
                    radius: 60.0,
                    backgroundColor: Colors.red.shade600,
                    child: Text(
                      classNum,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontFamily: 'LemonMilkBold',
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  margin: EdgeInsets.only(right: 10.0,bottom: 10.0),
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    shape: BoxShape.rectangle,
                  ),
                  child: Center(
                    child: Text(
                      numOfStudents,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontFamily: 'LemonMilkBold',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
