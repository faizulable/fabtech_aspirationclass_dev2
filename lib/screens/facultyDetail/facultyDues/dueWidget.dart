import 'package:flutter/material.dart';
import 'package:fabtech_aspirationclass_dev/utilites/getMonth.dart';

class DueWidget extends StatelessWidget {
  final String studentId,name,month,fees,session;
  DueWidget({this.studentId,this.name,this.month,this.fees,this.session});
  @override
  Widget build(BuildContext context) {
    String details = name + ' '  + convertNumtoMonth(month) + ' ' + session ;
    return Center(
      child: Card(
        elevation: 5.0,
        shadowColor: Colors.purpleAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        color: Colors.teal.shade100,
        child: SizedBox(
          height: 50.0,
          child: Row(
                children: [
                  Container(
                    width: 120.0,
                    child: Center(
                      child: Text(
                        studentId,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: amountHeadingTextStyle,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Text(
                        details,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: detailsTextStyle,
                      ),
                    ),
                  ),
                  Container(
                    width: 100.0,
                    child: Center(
                      child: Text(
                        fees,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: amountHeadingTextStyle,
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
const amountHeadingTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 15,
  fontFamily: 'Swansea',
  height: 0.8,
);

const detailsTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 13,
  fontFamily: 'Swansea',
  height: 0.8,
);