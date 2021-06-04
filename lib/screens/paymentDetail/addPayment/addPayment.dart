import 'package:fabtech_aspirationclass_dev/utilites/widgets/topHeadline.dart';
import 'package:fabtech_aspirationclass_dev/main.dart';
import 'package:fabtech_aspirationclass_dev/models/appPref.dart';
import 'package:fabtech_aspirationclass_dev/customPainter/LabelCustomPainter.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/BaseContainerL.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/BaseContainerR.dart';
import 'package:fabtech_aspirationclass_dev/utilites/stringListValues.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddPayment extends StatefulWidget {
  final String studentName;
  AddPayment({this.studentName});
  @override
  _AddPaymentState createState() => _AddPaymentState();
}

class _AddPaymentState extends State<AddPayment> {
  String _modeValue = modeList[0];
  String _amountNbrStr = '0';
  bool _aprSwitchValue = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.deepPurple.shade600, Colors.teal.shade400]
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          topContainer(widget.studentName,'ADD PAYMENT'),
          Container(
            padding: EdgeInsets.all(2.0),
            child: BaseContainerLeft(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width/2 -30,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomPaint(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Center(
                              child: Text('Session',
                                style: headingTextStyle,
                              ),
                            ),
                          ),
                          painter: RPSCustomPainter(
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Center(
                          child: Text( sp.getString(AppPref.sessionPref),
                            style: amountHeadingTextStyle,
                          ),
                        ),
                        SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/2 -30,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomPaint(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Center(
                              child: Text('Mode',
                                style: headingTextStyle,
                              ),
                            ),
                          ),
                          painter: RPSCustomPainter(
                          ),
                        ),
                        SizedBox(height: 5.0),
                        DropdownButton(
                          value: _modeValue,
                          onChanged: (newValue) {
                            setState(() {
                              _modeValue = newValue;
                            });
                          },
                          items: modeList.map((mode) {
                            return DropdownMenuItem(
                              child: Text(mode),
                              value: mode,
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 5.0),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              //color: Colors.teal.shade100,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      margin: EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        color: Colors.teal.shade100,
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        shape: BoxShape.rectangle,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            //flex: 1,
                            child: Center(
                              child: Text('APRIL',
                                style: amountHeadingTextStyle,
                              ),
                            ),
                          ),
                          Expanded(
                            //flex: 1,
                            child: Center(
                              child: Text('000',
                                style: amountHeadingTextStyle,
                              ),
                            ),
                          ),
                          Expanded(
                            //flex: 1,
                            child: Center(
                              child: Container(
                                width: 200,
                                child: SwitchListTile(
                                  title: Text('',
                                    style: amountHeadingTextStyle,
                                  ),
                                  value: _aprSwitchValue,
                                  onChanged: (bool value) {
                                    setState(() {
                                      _aprSwitchValue = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        color: Colors.teal.shade100,
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        shape: BoxShape.rectangle,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            //flex: 1,
                            child: Center(
                              child: Text('MAY',
                                style: amountHeadingTextStyle,
                              ),
                            ),
                          ),
                          Expanded(
                            //flex: 1,
                            child: Center(
                              child: Text('000',
                                style: amountHeadingTextStyle,
                              ),
                            ),
                          ),
                          Expanded(
                            //flex: 1,
                            child: Center(
                              child: Container(
                                width: 200,
                                child: SwitchListTile(
                                  title: Text('',
                                    style: amountHeadingTextStyle,
                                  ),
                                  value: _aprSwitchValue,
                                  onChanged: (bool value) {
                                    setState(() {
                                      _aprSwitchValue = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        color: Colors.teal.shade100,
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        shape: BoxShape.rectangle,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            //flex: 1,
                            child: Center(
                              child: Text('JUNE',
                                style: amountHeadingTextStyle,
                              ),
                            ),
                          ),
                          Expanded(
                            //flex: 1,
                            child: Center(
                              child: Text('000',
                                style: amountHeadingTextStyle,
                              ),
                            ),
                          ),
                          Expanded(
                            //flex: 1,
                            child: Center(
                              child: Container(
                                width: 200,
                                child: SwitchListTile(
                                  title: Text('',
                                    style: amountHeadingTextStyle,
                                  ),
                                  value: _aprSwitchValue,
                                  onChanged: (bool value) {
                                    setState(() {
                                      _aprSwitchValue = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        color: Colors.teal.shade100,
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        shape: BoxShape.rectangle,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            //flex: 1,
                            child: Center(
                              child: Text('JULY',
                                style: amountHeadingTextStyle,
                              ),
                            ),
                          ),
                          Expanded(
                            //flex: 1,
                            child: Center(
                              child: Text('000',
                                style: amountHeadingTextStyle,
                              ),
                            ),
                          ),
                          Expanded(
                            //flex: 1,
                            child: Center(
                              child: Container(
                                width: 200,
                                child: SwitchListTile(
                                  title: Text('',
                                    style: amountHeadingTextStyle,
                                  ),
                                  value: _aprSwitchValue,
                                  onChanged: (bool value) {
                                    setState(() {
                                      _aprSwitchValue = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        color: Colors.teal.shade100,
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        shape: BoxShape.rectangle,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            //flex: 1,
                            child: Center(
                              child: Text('AUGUST',
                                style: amountHeadingTextStyle,
                              ),
                            ),
                          ),
                          Expanded(
                            //flex: 1,
                            child: Center(
                              child: Text('000',
                                style: amountHeadingTextStyle,
                              ),
                            ),
                          ),
                          Expanded(
                            //flex: 1,
                            child: Center(
                              child: Container(
                                width: 200,
                                child: SwitchListTile(
                                  title: Text('',
                                    style: amountHeadingTextStyle,
                                  ),
                                  value: _aprSwitchValue,
                                  onChanged: (bool value) {
                                    setState(() {
                                      _aprSwitchValue = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        color: Colors.teal.shade100,
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        shape: BoxShape.rectangle,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            //flex: 1,
                            child: Center(
                              child: Text('SEPTEMBER',
                                style: amountHeadingTextStyle,
                              ),
                            ),
                          ),
                          Expanded(
                            //flex: 1,
                            child: Center(
                              child: Text('000',
                                style: amountHeadingTextStyle,
                              ),
                            ),
                          ),
                          Expanded(
                            //flex: 1,
                            child: Center(
                              child: Container(
                                width: 200,
                                child: SwitchListTile(
                                  title: Text('',
                                    style: amountHeadingTextStyle,
                                  ),
                                  value: _aprSwitchValue,
                                  onChanged: (bool value) {
                                    setState(() {
                                      _aprSwitchValue = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        color: Colors.teal.shade100,
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        shape: BoxShape.rectangle,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            //flex: 1,
                            child: Center(
                              child: Text('OCTOBER',
                                style: amountHeadingTextStyle,
                              ),
                            ),
                          ),
                          Expanded(
                            //flex: 1,
                            child: Center(
                              child: Text('000',
                                style: amountHeadingTextStyle,
                              ),
                            ),
                          ),
                          Expanded(
                            //flex: 1,
                            child: Center(
                              child: Container(
                                width: 200,
                                child: SwitchListTile(
                                  title: Text('',
                                    style: amountHeadingTextStyle,
                                  ),
                                  value: _aprSwitchValue,
                                  onChanged: (bool value) {
                                    setState(() {
                                      _aprSwitchValue = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        color: Colors.teal.shade100,
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        shape: BoxShape.rectangle,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            //flex: 1,
                            child: Center(
                              child: Text('NOVEMBER',
                                style: amountHeadingTextStyle,
                              ),
                            ),
                          ),
                          Expanded(
                            //flex: 1,
                            child: Center(
                              child: Text('000',
                                style: amountHeadingTextStyle,
                              ),
                            ),
                          ),
                          Expanded(
                            //flex: 1,
                            child: Center(
                              child: Container(
                                width: 200,
                                child: SwitchListTile(
                                  title: Text('',
                                    style: amountHeadingTextStyle,
                                  ),
                                  value: _aprSwitchValue,
                                  onChanged: (bool value) {
                                    setState(() {
                                      _aprSwitchValue = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        color: Colors.teal.shade100,
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        shape: BoxShape.rectangle,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            //flex: 1,
                            child: Center(
                              child: Text('DECEMBER',
                                style: amountHeadingTextStyle,
                              ),
                            ),
                          ),
                          Expanded(
                            //flex: 1,
                            child: Center(
                              child: Text('000',
                                style: amountHeadingTextStyle,
                              ),
                            ),
                          ),
                          Expanded(
                            //flex: 1,
                            child: Center(
                              child: Container(
                                width: 200,
                                child: SwitchListTile(
                                  title: Text('',
                                    style: amountHeadingTextStyle,
                                  ),
                                  value: _aprSwitchValue,
                                  onChanged: (bool value) {
                                    setState(() {
                                      _aprSwitchValue = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        color: Colors.teal.shade100,
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        shape: BoxShape.rectangle,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            //flex: 1,
                            child: Center(
                              child: Text('JANUARY',
                                style: amountHeadingTextStyle,
                              ),
                            ),
                          ),
                          Expanded(
                            //flex: 1,
                            child: Center(
                              child: Text('000',
                                style: amountHeadingTextStyle,
                              ),
                            ),
                          ),
                          Expanded(
                            //flex: 1,
                            child: Center(
                              child: Container(
                                width: 200,
                                child: SwitchListTile(
                                  title: Text('',
                                    style: amountHeadingTextStyle,
                                  ),
                                  value: _aprSwitchValue,
                                  onChanged: (bool value) {
                                    setState(() {
                                      _aprSwitchValue = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        color: Colors.teal.shade100,
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        shape: BoxShape.rectangle,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            //flex: 1,
                            child: Center(
                              child: Text('FEBRUARY',
                                style: amountHeadingTextStyle,
                              ),
                            ),
                          ),
                          Expanded(
                            //flex: 1,
                            child: Center(
                              child: Text('000',
                                style: amountHeadingTextStyle,
                              ),
                            ),
                          ),
                          Expanded(
                            //flex: 1,
                            child: Center(
                              child: Container(
                                width: 200,
                                child: SwitchListTile(
                                  title: Text('',
                                    style: amountHeadingTextStyle,
                                  ),
                                  value: _aprSwitchValue,
                                  onChanged: (bool value) {
                                    setState(() {
                                      _aprSwitchValue = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        color: Colors.teal.shade100,
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        shape: BoxShape.rectangle,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            //flex: 1,
                            child: Center(
                              child: Text('MARCH',
                                style: amountHeadingTextStyle,
                              ),
                            ),
                          ),
                          Expanded(
                            //flex: 1,
                            child: Center(
                              child: Text('000',
                                style: amountHeadingTextStyle,
                              ),
                            ),
                          ),
                          Expanded(
                            //flex: 1,
                            child: Center(
                              child: Container(
                                width: 200,
                                child: SwitchListTile(
                                  title: Text('',
                                    style: amountHeadingTextStyle,
                                  ),
                                  value: _aprSwitchValue,
                                  onChanged: (bool value) {
                                    setState(() {
                                      _aprSwitchValue = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(2.0),
            child: BaseContainerRight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width/3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomPaint(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Center(
                              child: Text('Total Sum',
                                style: headingTextStyle,
                              ),
                            ),
                          ),
                          painter: RPSCustomPainter(
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Center(
                          child: Text( '0000',
                            style: amountHeadingTextStyle,
                          ),
                        ),
                        SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomPaint(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Center(
                              child: Text('Pay Amount',
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
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Cannot be blank';
                              }
                              if (value.length > 10) {
                                return 'Invalid amount';
                              }
                              return null;
                            },
                            onSaved: (input) => _amountNbrStr = input,
                          ),
                        ),
                        SizedBox(height: 5.0),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.teal.shade400),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20),),
                          ),
                        ),
                      ),
                      //icon: Icon(Icons.exit_to_app_rounded),
                      child: Text('Save'),
                      onPressed: () async {
                        //TODO Save the data into the file
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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