import 'package:flutter/material.dart';

class PaidListWidget extends StatelessWidget {
  final String refNum,monthSubject,date,amount,mode;
  PaidListWidget({this.refNum,this.monthSubject,this.date,this.amount,this.mode});

  @override
  Widget build(BuildContext context) {
    bool _isDefaulter = false;
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
                            child: SelectableText(refNum,
                            style: studentIdTextStyle,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(monthSubject,
                            style: studentNameTextStyle,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Row(
                          children: [
                            Text('Date: ',
                              style: subHeadingTextStyle,
                            ),
                            Text(date,
                              style: subValueTextStyle,
                            ),
                            SizedBox(width: 5.0),
                            Text('Amount: ',
                              style: subHeadingTextStyle,
                            ),
                            Text(amount,
                              style: subValueTextStyle,
                            ),
                            SizedBox(width: 5.0),
                            Text('Mode: ',
                              style: subHeadingTextStyle,
                            ),
                            Text(mode,
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