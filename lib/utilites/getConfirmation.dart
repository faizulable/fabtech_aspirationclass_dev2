import 'package:flutter/material.dart';
bool returnValue;
String globalComment;
BuildContext globalContext;

Future<bool> confirmationDialog(BuildContext context, String comment) async{
  globalComment = comment;
  globalContext = context;
  await myDialog();
  return returnValue;
}

Future<void>myDialog() {
  //String windowFees,windowSubject,windowFaculty,windowDue;
  return showDialog<void>(
    context: globalContext,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return StatefulBuilder(builder: (context, StateSetter setState){
        return AlertDialog(
          contentPadding: EdgeInsets.all(5.0),
          backgroundColor: Colors.teal.shade100,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
          title: Center(
            child: Text(
              'Please Confirm',
              style: mainHeadingTextStyle,
            ),
          ),
          content: Container(
            width: 100,
            height: 100,
            child: Center(
              child: Text(globalComment,
                textAlign: TextAlign.center,
                style: windowTextStyle,
              ),
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.purpleAccent),
                shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                ),
              ),
              child: Text('Yes'),
              onPressed: () {
                returnValue = true;
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.purpleAccent),
                shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                ),
              ),
              child: Text('Cancel'),
              onPressed: () {
                returnValue = false;
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
    },
  );
}
//

const mainHeadingTextStyle = TextStyle(
  color: Colors.red,
  fontSize: 30,
  fontFamily: 'yellowRabbit',
);

const windowTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 20,
  fontFamily: 'Swansea',
);