import 'package:flutter/material.dart';

class ListWidgetFacSub extends StatelessWidget {
  final String subject,perFacultyShare,perBranchShare,status;
  ListWidgetFacSub({this.subject,this.perFacultyShare,this.perBranchShare,this.status});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 10.0,
        shadowColor: Colors.purpleAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        color: (status == 'A') ? Colors.teal.shade100 : Colors.grey,
        child: SizedBox(
          height: 90.0,
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
                            color: Colors.teal.shade400,
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            shape: BoxShape.rectangle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(subject,
                            style: studentIdTextStyle,
                            ),
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Row(
                          children: [
                            Text('FacShare(%) : ',
                              style: subHeadingTextStyle,
                            ),
                            Text(perFacultyShare,
                              style: subValueTextStyle,
                            ),
                            SizedBox(width: 5.0),
                            Text('AspShare(%) : ',
                              style: subHeadingTextStyle,
                            ),
                            Text(perBranchShare,
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
  fontSize: 30,
  fontFamily: 'Swansea',
);

const subValueTextStyle = TextStyle(
  color: Colors.black54,
  fontSize: 25,
  fontFamily: 'LandasansMedium',
);

const subHeadingTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 25,
  fontFamily: 'LandasansMedium',
);