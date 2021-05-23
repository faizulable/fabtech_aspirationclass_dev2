import 'package:fabtech_aspirationclass_dev/models/appPref.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/header.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/topHeadline.dart';
import 'package:fabtech_aspirationclass_dev/main.dart';
import 'package:fabtech_aspirationclass_dev/customPainter/LabelCustomPainter.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/BaseContainerL.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/BaseContainerR.dart';
import 'package:fabtech_aspirationclass_dev/utilites/stringListValues.dart';
import 'package:fabtech_aspirationclass_dev/utilites/getDate.dart';


class AddPageOne extends StatefulWidget {
  final String classNumStr;
  AddPageOne({this.classNumStr});

  @override
  _AddPageOneState createState() => _AddPageOneState();
}

class _AddPageOneState extends State<AddPageOne> {
  String _genderValue = genderList[0];
  String _dateValue = 'DD/MM/YY';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, 'ADD STUDENT'),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.deepPurple.shade600, Colors.teal.shade400]
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    topContainer('CLASS '+widget.classNumStr,sp.getString(AppPref.userNamePref)),
                    Container(
                      padding: EdgeInsets.all(2.0),
                      child: BaseContainerRight(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomPaint(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Center(
                                  child: Text('Student Name',
                                    style: headingTextStyle,
                                  ),
                                ),
                              ),
                              painter: RPSCustomPainter(
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Center(
                              child: TextFormField(
                                decoration: inputNameDecoration,
                              ),
                            ),
                            SizedBox(height: 5.0),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(2.0),
                      child: BaseContainerRight(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomPaint(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Center(
                                  child: Text('Email ID',
                                    style: headingTextStyle,
                                  ),
                                ),
                              ),
                              painter: RPSCustomPainter(
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Center(
                              child: TextFormField(
                                decoration: inputEmailDecoration,
                              ),
                            ),
                            SizedBox(height: 5.0),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          //height: MediaQuery.of(context).size.height/8,
                          width: MediaQuery.of(context).size.width/2 - 5,
                          //padding: EdgeInsets.all(2.0),
                          child: BaseContainerLeft(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomPaint(
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Center(
                                      child: Text('Contact Num',
                                        style: headingTextStyle,
                                      ),
                                    ),
                                  ),
                                  painter: RPSCustomPainter(
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Center(
                                  child: TextFormField(
                                    decoration: inputContactDecoration,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5.0),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          //height: MediaQuery.of(context).size.height/8,
                          width: MediaQuery.of(context).size.width/2 -5,
                          child: BaseContainerLeft(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomPaint(
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Center(
                                      child: Text('Gender',
                                        style: headingTextStyle,
                                      ),
                                    ),
                                  ),
                                  painter: RPSCustomPainter(
                                  ),
                                ),
                                //SizedBox(height: 5.0),
                                DropdownButton(
                                  value: _genderValue,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _genderValue = newValue;
                                    });
                                  },
                                  items: genderList.map((gender) {
                                    return DropdownMenuItem(
                                      child: Text(gender),
                                      value: gender,
                                    );
                                  }).toList(),
                                ),
                                SizedBox(height: 5.0),
                              ],
                            ),
                          ),
                        ),
                      ],

                    ),
                    SizedBox(height: 5.0),
                    Container(
                      padding: EdgeInsets.all(2.0),
                      child: BaseContainerRight(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomPaint(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Center(
                                  child: Text('Date of Admission (DoA)',
                                    style: headingTextStyle,
                                  ),
                                ),
                              ),
                              painter: RPSCustomPainter(
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _dateValue,
                                  style: amountHeadingTextStyle,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                IconButton(
                                  icon: Icon(Icons.date_range),
                                  onPressed: () async {
                                    String val = await callDatePicker(context);
                                    setState(() {
                                      _dateValue = val;
                                    });
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 5.0),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Container(
                      padding: EdgeInsets.all(2.0),
                      child: BaseContainerRight(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomPaint(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Center(
                                  child: Text('School Name',
                                    style: headingTextStyle,
                                  ),
                                ),
                              ),
                              painter: RPSCustomPainter(
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Center(
                              child: TextFormField(
                                decoration: inputSchoolDecoration,
                              ),
                            ),
                            SizedBox(height: 5.0),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          //height: MediaQuery.of(context).size.height/8,
                          width: MediaQuery.of(context).size.width/2 - 5,
                          //padding: EdgeInsets.all(2.0),
                          child: BaseContainerLeft(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomPaint(
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Center(
                                      child: Text('Board',
                                        style: headingTextStyle,
                                      ),
                                    ),
                                  ),
                                  painter: RPSCustomPainter(
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Center(
                                  child: TextFormField(
                                    decoration: inputBoardDecoration,
                                  ),
                                ),
                                SizedBox(height: 5.0),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          //height: MediaQuery.of(context).size.height/8,
                          width: MediaQuery.of(context).size.width/2 -5,
                          child: BaseContainerLeft(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomPaint(
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Center(
                                      child: Text('Admission fees',
                                        style: headingTextStyle,
                                      ),
                                    ),
                                  ),
                                  painter: RPSCustomPainter(
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Center(
                                  child: TextFormField(
                                    decoration: inputFeeDecoration,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5.0),
                              ],
                            ),
                          ),
                        ),
                      ],

                    ),
                    SizedBox(height: 10.0),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 15.0),
                child: FloatingActionButton(
                  child: Icon(Icons.navigate_next, size: 50.0,),
                  onPressed: () {
                    //TODO make a call to subject list
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const headingTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 25,
  fontFamily: 'yellowRabbit',
);

const amountHeadingTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 20,
  fontFamily: 'Swansea',
);

const inputNameDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  hintText: 'Student Name',
  hintStyle: TextStyle(
    fontSize: 12,
  ),
  border: OutlineInputBorder(
    borderRadius:
    BorderRadius.all(Radius.circular(25),
    ),
    borderSide:
    BorderSide(width: 3,color: Colors.redAccent,style: BorderStyle.solid),
  ),
);

const inputEmailDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  hintText: 'Enter EmailId',
  hintStyle: TextStyle(
    fontSize: 12,
  ),
  border: OutlineInputBorder(
    borderRadius:
    BorderRadius.all(Radius.circular(25),
    ),
    borderSide:
    BorderSide(width: 3,color: Colors.redAccent,style: BorderStyle.solid),
  ),
);

const inputSchoolDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  hintText: 'Enter School Name',
  hintStyle: TextStyle(
    fontSize: 12,
  ),
  border: OutlineInputBorder(
    borderRadius:
    BorderRadius.all(Radius.circular(25),
    ),
    borderSide:
    BorderSide(width: 3,color: Colors.redAccent,style: BorderStyle.solid),
  ),
);

const inputBoardDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  hintText: 'ICSE',
  hintStyle: TextStyle(
    fontSize: 12,
  ),
  border: OutlineInputBorder(
    borderRadius:
    BorderRadius.all(Radius.circular(25),
    ),
    borderSide:
    BorderSide(width: 3,color: Colors.redAccent,style: BorderStyle.solid),
  ),
);

const inputContactDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  hintText: '9999999999',
  hintStyle: TextStyle(
    fontSize: 12,
  ),
  border: OutlineInputBorder(
    borderRadius:
    BorderRadius.all(Radius.circular(25),
    ),
    borderSide:
    BorderSide(width: 3,color: Colors.redAccent,style: BorderStyle.solid),
  ),
);

const inputFeeDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  hintText: '₹0000',
  hintStyle: TextStyle(
    fontSize: 12,
  ),
  border: OutlineInputBorder(
    borderRadius:
    BorderRadius.all(Radius.circular(25),
    ),
    borderSide:
    BorderSide(width: 3,color: Colors.redAccent,style: BorderStyle.solid),
  ),
);
