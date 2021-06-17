import 'package:flutter/material.dart';

class ListWidgetFac2 extends StatelessWidget {
  final String facultyId,name,contact,status;
  ListWidgetFac2({this.facultyId,this.name,this.contact,this.status});

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
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: studentNameTextStyle,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: SelectableText(contact,
                            style: studentIdTextStyle,
                          ),
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