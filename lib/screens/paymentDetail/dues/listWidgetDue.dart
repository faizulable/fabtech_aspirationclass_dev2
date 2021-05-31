import 'package:flutter/material.dart';

class ListDueWidget extends StatelessWidget {
  final String month,due,aspShare,facShare;
  ListDueWidget({this.month,this.due,this.aspShare,this.facShare});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 10.0,
        shadowColor: Colors.purpleAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        color: Colors.grey,
        child: SizedBox(
          height: 65.0,
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
                          child: Text(month,
                            style: studentNameTextStyle,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Row(
                          children: [
                            Text('Due: ',
                              style: subHeadingTextStyle,
                            ),
                            Text(due,
                              style: subValueTextStyle,
                            ),
                            SizedBox(width: 5.0),
                            Text('AspShare(₹): ',
                              style: subHeadingTextStyle,
                            ),
                            Text(aspShare,
                              style: subValueTextStyle,
                            ),
                            SizedBox(width: 5.0),
                            Text('FacShare(₹): ',
                              style: subHeadingTextStyle,
                            ),
                            Text(facShare,
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