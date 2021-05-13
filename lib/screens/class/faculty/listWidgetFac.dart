import 'package:flutter/material.dart';

class ListWidgetFac extends StatelessWidget {
  final String facultyId,name,subject,contact,perFacultyShare,perBranchShare;
  ListWidgetFac({this.facultyId,this.name,this.subject,this.contact,this.perFacultyShare,this.perBranchShare});

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
          height: 120.0,
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
                            child: Text(facultyId,
                            style: studentIdTextStyle,
                            ),
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(name,
                            style: studentNameTextStyle,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(subject,
                            style: studentIdTextStyle,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Row(
                          children: [
                            Text('Contact: ',
                              style: subHeadingTextStyle,
                            ),
                            Text(contact,
                              style: subValueTextStyle,
                            ),
                            SizedBox(width: 5.0),
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
  fontSize: 18,
  fontFamily: 'LandasansMedium',
);

const subHeadingTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 18,
  fontFamily: 'LandasansMedium',
);