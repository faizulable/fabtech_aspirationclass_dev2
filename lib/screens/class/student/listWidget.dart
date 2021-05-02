import 'package:flutter/material.dart';
import 'package:fabtech_aspirationclass_dev/utilites/constantValue.dart';

class ListWidget extends StatelessWidget {
  final String studentId,name,contact,monthlyfees,dues;
  ListWidget({this.studentId,this.name,this.contact,this.monthlyfees,this.dues});

  @override
  Widget build(BuildContext context) {
    bool _isDefaulter = false;
    //check for defaulter
    if(int.parse(dues) > 0) {
      _isDefaulter = true;
    }
    return Center(
      child: Card(
        elevation: 10.0,
        shadowColor: Colors.purpleAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        color: Colors.teal.shade100,
        child: SizedBox(
          height: 130.0,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            color: _isDefaulter ? Colors.red : Colors.teal.shade400,
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            shape: BoxShape.rectangle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(studentId,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontFamily: 'LemonMilkLight',
                            ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(name,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontFamily: 'LemonMilkBold',
                            ),
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Row(
                          children: [
                            Text('Contact: ',
                              style: tertiaryHeadingTextStyle,
                            ),
                            Text(contact,
                              style: tertiaryValueTextStyle,
                            ),
                            SizedBox(width: 5.0),
                            Text('Amount: ',
                              style: tertiaryHeadingTextStyle,
                            ),
                            Text(monthlyfees,
                              style: tertiaryValueTextStyle,
                            ),
                            SizedBox(width: 5.0),
                            Text('Dues: ',
                              style: tertiaryHeadingTextStyle,
                            ),
                            Text(dues,
                              style: tertiaryValueTextStyle,
                            ),
                          ],
                        ),
                      ],
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
