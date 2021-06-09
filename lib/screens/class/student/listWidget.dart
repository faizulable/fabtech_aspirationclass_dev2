import 'package:flutter/material.dart';

class ListWidget extends StatelessWidget {
  final String studentId,name,contact,monthlyfees,dues,subCount;
  ListWidget({this.studentId,this.name,this.contact,this.monthlyfees,this.dues,this.subCount});

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
                            style: studentIdTextStyle,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(name,
                            style: studentNameTextStyle,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Row(
                          children: [
                            Text('Contact: ',
                              style: subHeadingTextStyle,
                            ),
                            SelectableText(contact,
                              style: subValueTextStyle,
                            ),
                            SizedBox(width: 5.0),
                            Text('Amount: ',
                              style: subHeadingTextStyle,
                            ),
                            Text(monthlyfees,
                              style: subValueTextStyle,
                            ),
                            SizedBox(width: 5.0),
                            Text('Dues: ',
                              style: subHeadingTextStyle,
                            ),
                            Text(dues,
                              style: subValueTextStyle,
                            ),
                            SizedBox(width: 5.0),
                            Text('SubCount: ',
                              style: subHeadingTextStyle,
                            ),
                            Text(subCount,
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