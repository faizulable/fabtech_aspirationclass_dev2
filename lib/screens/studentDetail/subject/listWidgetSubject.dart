import 'package:flutter/material.dart';

class ListSubjectWidget extends StatelessWidget {
  final String facultyId,subject,fee,due,status,dateOfEnrol;
  final Function crossFunction, miscFunction;
  ListSubjectWidget({this.facultyId,this.subject,this.fee,this.due,this.status,this.dateOfEnrol,
    this.crossFunction,this.miscFunction});

  @override
  Widget build(BuildContext context) {
    //check for defaulter
    bool _isDefaulter = false;
    if(int.parse(due) > 0) {
      _isDefaulter = true;
    }

    return Center(
      child: Card(
        elevation: 10.0,
        shadowColor: Colors.purpleAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        color: (status == 'A') ? Colors.teal.shade100 : Colors.grey,
        child: SizedBox(
          height: 100.0,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  color: _isDefaulter ? Colors.red : Colors.teal.shade400,
                                  borderRadius: BorderRadius.all(Radius.circular(25)),
                                  shape: BoxShape.rectangle,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(facultyId,
                                    style: studentIdTextStyle,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 5.0),
                            GestureDetector(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  color: _isDefaulter ? Colors.red : Colors.teal.shade400,
                                  borderRadius: BorderRadius.all(Radius.circular(90)),
                                  shape: BoxShape.rectangle,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Icon(Icons.add_box_rounded),
                                ),
                              ),
                              onTap: miscFunction,
                            ),
                            SizedBox(width: 5.0),
                            (status == 'A') ? GestureDetector(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  color: _isDefaulter ? Colors.red : Colors.teal.shade400,
                                  borderRadius: BorderRadius.all(Radius.circular(90)),
                                  shape: BoxShape.rectangle,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Icon(Icons.clear),
                                  ),
                                ),
                              onTap: crossFunction,
                            ) : Container(),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(subject,
                            style: studentNameTextStyle,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Row(
                          children: [
                            Text('Month of Enroll: ',
                              style: subHeadingTextStyle,
                            ),
                            Text(dateOfEnrol,
                              style: subValueTextStyle,
                            ),
                            SizedBox(width: 5.0),
                            Text('Fee: ',
                              style: subHeadingTextStyle,
                            ),
                            Text(fee,
                              style: subValueTextStyle,
                            ),
                            SizedBox(width: 5.0),
                            Text('Due: ',
                              style: subHeadingTextStyle,
                            ),
                            Text(due,
                              style: subValueTextStyle,
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

//Text Styling
const studentIdTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 20,
  fontFamily: 'Swansea',
);
const studentNameTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 20,
  fontFamily: 'LemonMilkBold',
);

const subValueTextStyle = TextStyle(
  color: Colors.black54,
  fontSize: 15,
  fontFamily: 'LandasansMedium',
);

const subHeadingTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 15,
  fontFamily: 'LandasansMedium',
);