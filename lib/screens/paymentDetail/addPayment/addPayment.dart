import 'package:fabtech_aspirationclass_dev/utilites/constantValue.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/topHeadline.dart';
import 'package:fabtech_aspirationclass_dev/main.dart';
import 'package:fabtech_aspirationclass_dev/models/appPref.dart';
import 'package:fabtech_aspirationclass_dev/customPainter/LabelCustomPainter.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/BaseContainerL.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/BaseContainerR.dart';
import 'package:fabtech_aspirationclass_dev/utilites/stringListValues.dart';
import 'package:fabtech_aspirationclass_dev/services/processPayment.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fabtech_aspirationclass_dev/models/PY002P.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/progress.dart';
import 'package:fabtech_aspirationclass_dev/utilites/getConfirmation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class AddPayment extends StatefulWidget {
  final String studentName,subjectFee,studentID,facultyID,subject,classNbr;
  AddPayment({this.studentName,this.subjectFee,this.studentID,this.facultyID,this.subject,this.classNbr});
  @override
  _AddPaymentState createState() => _AddPaymentState();
}

class _AddPaymentState extends State<AddPayment> {
  final _formKey = GlobalKey<FormState>();
  String _modeValue = modeList[0];
  String _amountNbrStr = '0';
  String _payableSumStr = '000';
  int _payableSum = 0;
  List<DueList> _dueList = [];
  List<PaidList> _paidList = [];
  List<MonthList> _selectedMonth = [];
  bool _isLoading = true;
  bool _isSave = false;

  String _feeApr = '';
  String _feeMay = '';
  String _feeJun = '';
  String _feeJly = '';
  String _feeAug = '';
  String _feeSep = '';
  String _feeOct = '';
  String _feeNov = '';
  String _feeDec = '';
  String _feeJan = '';
  String _feeFeb = '';
  String _feeMar = '';

  Color _colorApr = Colors.teal.shade100;
  Color _colorMay = Colors.teal.shade100;
  Color _colorJun = Colors.teal.shade100;
  Color _colorJly = Colors.teal.shade100;
  Color _colorAug = Colors.teal.shade100;
  Color _colorSep = Colors.teal.shade100;
  Color _colorOct = Colors.teal.shade100;
  Color _colorNov = Colors.teal.shade100;
  Color _colorDec = Colors.teal.shade100;
  Color _colorJan = Colors.teal.shade100;
  Color _colorFeb = Colors.teal.shade100;
  Color _colorMar = Colors.teal.shade100;

  bool _visibilityApr = true;
  bool _visibilityMay = true;
  bool _visibilityJun = true;
  bool _visibilityJly = true;
  bool _visibilityAug = true;
  bool _visibilitySep = true;
  bool _visibilityOct = true;
  bool _visibilityNov = true;
  bool _visibilityDec = true;
  bool _visibilityJan = true;
  bool _visibilityFeb = true;
  bool _visibilityMar = true;



  bool _aprSwitchValue = false;
  bool _maySwitchValue = false;
  bool _junSwitchValue = false;
  bool _jlySwitchValue = false;
  bool _augSwitchValue = false;
  bool _sepSwitchValue = false;
  bool _octSwitchValue = false;
  bool _novSwitchValue = false;
  bool _decSwitchValue = false;
  bool _janSwitchValue = false;
  bool _febSwitchValue = false;
  bool _marSwitchValue = false;



  @override
  void initState() {
    _initMonthFee();
    getPayAndDue();
    super.initState();
  }

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
      child: _isLoading ? circularProgress() : Column(
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
                        color: _colorApr,
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
                              child: Text(_feeApr,
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
                                  onChanged: _visibilityApr ? (bool value) {
                                    setState(() {
                                      _aprSwitchValue = value;
                                      if(_aprSwitchValue){
                                        _payableSum = _payableSum + int.parse(_feeApr);
                                        _payableSumStr = _payableSum.toString();
                                      } else {
                                        _payableSum = _payableSum - int.parse(_feeApr);
                                        _payableSumStr = _payableSum.toString();
                                      }
                                    });
                                  } : null,
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
                        color: _colorMay,
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
                              child: Text(_feeMay,
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
                                  value: _maySwitchValue,
                                  onChanged: _visibilityMay ? (bool value) {
                                    setState(() {
                                      _maySwitchValue = value;
                                      if(_maySwitchValue){
                                        _payableSum = _payableSum + int.parse(_feeMay);
                                        _payableSumStr = _payableSum.toString();
                                      } else {
                                        _payableSum = _payableSum - int.parse(_feeMay);
                                        _payableSumStr = _payableSum.toString();
                                      }
                                    });
                                  } : null,
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
                        color: _colorJun,
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
                              child: Text(_feeJun,
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
                                  value: _junSwitchValue,
                                  onChanged: _visibilityJun ? (bool value) {
                                    setState(() {
                                      _junSwitchValue = value;
                                      if(_junSwitchValue){
                                        _payableSum = _payableSum + int.parse(_feeJun);
                                        _payableSumStr = _payableSum.toString();
                                      } else {
                                        _payableSum = _payableSum - int.parse(_feeJun);
                                        _payableSumStr = _payableSum.toString();
                                      }
                                    });
                                  } : null,
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
                        color: _colorJly,
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
                              child: Text(_feeJly,
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
                                  value: _jlySwitchValue,
                                  onChanged: _visibilityJly ? (bool value) {
                                    setState(() {
                                      _jlySwitchValue = value;
                                      if(_jlySwitchValue){
                                        _payableSum = _payableSum + int.parse(_feeJly);
                                        _payableSumStr = _payableSum.toString();
                                      } else {
                                        _payableSum = _payableSum - int.parse(_feeJly);
                                        _payableSumStr = _payableSum.toString();
                                      }
                                    });
                                  } : null,
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
                        color: _colorAug,
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
                              child: Text(_feeAug,
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
                                  value: _augSwitchValue,
                                  onChanged: _visibilityAug ? (bool value) {
                                    setState(() {
                                      _augSwitchValue = value;
                                      if(_augSwitchValue){
                                        _payableSum = _payableSum + int.parse(_feeAug);
                                        _payableSumStr = _payableSum.toString();
                                      } else {
                                        _payableSum = _payableSum - int.parse(_feeAug);
                                        _payableSumStr = _payableSum.toString();
                                      }
                                    });
                                  }: null,
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
                        color: _colorSep,
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
                              child: Text(_feeSep,
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
                                  value: _sepSwitchValue,
                                  onChanged: _visibilitySep ? (bool value) {
                                    setState(() {
                                      _sepSwitchValue = value;
                                      if(_sepSwitchValue){
                                        _payableSum = _payableSum + int.parse(_feeSep);
                                        _payableSumStr = _payableSum.toString();
                                      } else {
                                        _payableSum = _payableSum - int.parse(_feeSep);
                                        _payableSumStr = _payableSum.toString();
                                      }
                                    });
                                  } : null,
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
                        color: _colorOct,
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
                              child: Text(_feeOct,
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
                                  value: _octSwitchValue,
                                  onChanged: _visibilityOct ? (bool value) {
                                    setState(() {
                                      _octSwitchValue = value;
                                      if(_octSwitchValue){
                                        _payableSum = _payableSum + int.parse(_feeOct);
                                        _payableSumStr = _payableSum.toString();
                                      } else {
                                        _payableSum = _payableSum - int.parse(_feeOct);
                                        _payableSumStr = _payableSum.toString();
                                      }
                                    });
                                  } : null,
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
                        color: _colorNov,
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
                              child: Text(_feeNov,
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
                                  value: _novSwitchValue,
                                  onChanged: _visibilityNov ? (bool value) {
                                    setState(() {
                                      _novSwitchValue = value;
                                      if(_novSwitchValue){
                                        _payableSum = _payableSum + int.parse(_feeNov);
                                        _payableSumStr = _payableSum.toString();
                                      } else {
                                        _payableSum = _payableSum - int.parse(_feeNov);
                                        _payableSumStr = _payableSum.toString();
                                      }
                                    });
                                  } : null,
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
                        color: _colorDec,
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
                              child: Text(_feeDec,
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
                                  value: _decSwitchValue,
                                  onChanged: _visibilityDec ? (bool value) {
                                    setState(() {
                                      _decSwitchValue = value;
                                      if(_decSwitchValue){
                                        _payableSum = _payableSum + int.parse(_feeDec);
                                        _payableSumStr = _payableSum.toString();
                                      } else {
                                        _payableSum = _payableSum - int.parse(_feeDec);
                                        _payableSumStr = _payableSum.toString();
                                      }
                                    });
                                  } : null,
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
                        color: _colorJan,
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
                              child: Text(_feeJan,
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
                                  value: _janSwitchValue,
                                  onChanged: _visibilityJan ? (bool value) {
                                    setState(() {
                                      _janSwitchValue = value;
                                      if(_janSwitchValue){
                                        _payableSum = _payableSum + int.parse(_feeJan);
                                        _payableSumStr = _payableSum.toString();
                                      } else {
                                        _payableSum = _payableSum - int.parse(_feeJan);
                                        _payableSumStr = _payableSum.toString();
                                      }
                                    });
                                  } : null,
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
                        color: _colorFeb,
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
                              child: Text(_feeFeb,
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
                                  value: _febSwitchValue,
                                  onChanged: _visibilityFeb ? (bool value) {
                                    setState(() {
                                      _febSwitchValue = value;
                                      if(_febSwitchValue){
                                        _payableSum = _payableSum + int.parse(_feeFeb);
                                        _payableSumStr = _payableSum.toString();
                                      } else {
                                        _payableSum = _payableSum - int.parse(_feeFeb);
                                        _payableSumStr = _payableSum.toString();
                                      }
                                    });
                                  } : null,
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
                        color: _colorMar,
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
                              child: Text(_feeMar,
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
                                  value: _marSwitchValue,
                                  onChanged: _visibilityMar ? (bool value) {
                                    setState(() {
                                      _marSwitchValue = value;
                                      if(_marSwitchValue){
                                        _payableSum = _payableSum + int.parse(_feeMar);
                                        _payableSumStr = _payableSum.toString();
                                      } else {
                                        _payableSum = _payableSum - int.parse(_feeMar);
                                        _payableSumStr = _payableSum.toString();
                                      }
                                    });
                                  } : null,
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
                          child: Text( _payableSumStr,
                            style: amountHeadingTextStyle,
                          ),
                        ),
                        SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/3,
                    child: Form(
                      key: _formKey,
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
                                if (value.length > 9) {
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
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5.0),
                    child: _isSave ? circularProgress() : ElevatedButton(
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
                        if (_formKey.currentState.validate()){
                          _formKey.currentState.save();
                          getSelectedMonth();
                          if(_selectedMonth.length>0){
                            bool confirm = await confirmationDialog(context,'Do you want to save this Payment transaction ?');
                            if(confirm){
                                setState(() {
                                  _isSave = true;
                                });
                                String jsonMonthList = jsonEncode(_selectedMonth);
                                //print(jsonMonthList);
                                bool result = await createMonthlyPayment(jsonMonthList);
                                if(result){
                                  Navigator.pop(context,result);
                                } else {
                                  setState(() {
                                    _isSave = false;
                                  });
                                }
                            }
                          } else {
                            EasyLoading.showToast('Please select a month');
                          }
                        }
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
  //
  getPayAndDue() async {
    _dueList = [];
    _paidList = [];
    try {
      ProcessPaymentService processPaymentService = ProcessPaymentService();
      dynamic httpResult = await processPaymentService.getPaymentDues(kGetPaymentAdDue,widget.studentID,widget.facultyID,widget.subject);
      String positiveStatus = 'true';
      //failed as server end
      if(httpResult is String){
        EasyLoading.showToast(httpResult);
        setState(() {
          _isLoading = false;
        });
      }
      //data fetch from server end
      if(httpResult['status'] == positiveStatus){
        //paid list data
        httpResult['paidData'].forEach((element){
          _paidList.add(PaidList(element[PY002P.monthFld], element[PY002P.feeFld]));
        });
        //due list data
        httpResult['dueData'].forEach((element){
          _dueList.add(DueList(element[PY002P.monthFld], element[PY002P.feeFld]));
        });
      } else {
        EasyLoading.showToast(httpResult['message']);
      }
    } catch (e) {
      EasyLoading.showToast(e.toString());
      setState(() {
        _isLoading = false;
      });
    }
    //finally hide the progress bar
    setState(() {
      _dueList.forEach((element) {
        if(element.month == '04')
        {_feeApr = element.due;
          _colorApr = Colors.red.shade300;}
        if(element.month == '05')
        {_feeMay = element.due;
          _colorMay = Colors.red.shade300;}
        if(element.month == '06')
        {_feeJun = element.due;
        _colorJun = Colors.red.shade300;}
        if(element.month == '07')
        {_feeJly = element.due;
        _colorJly = Colors.red.shade300;}
        if(element.month == '08')
        {_feeAug = element.due;
        _colorAug = Colors.red.shade300;}
        if(element.month == '09')
        {_feeSep = element.due;
        _colorSep = Colors.red.shade300;}
        if(element.month == '10')
        {_feeOct = element.due;
        _colorOct = Colors.red.shade300;}
        if(element.month == '11')
        {_feeNov = element.due;
        _colorNov = Colors.red.shade300;}
        if(element.month == '12')
        {_feeDec = element.due;
        _colorDec = Colors.red.shade300;}
        if(element.month == '01')
        {_feeJan = element.due;
        _colorJan = Colors.red.shade300;}
        if(element.month == '02')
        {_feeFeb = element.due;
        _colorFeb = Colors.red.shade300;}
        if(element.month == '03')
        {_feeMar = element.due;
        _colorMar = Colors.red.shade300;}
      });
      _paidList.forEach((element) {
        if(element.month == '04')
        {_feeApr = element.fee;
        _colorApr = Colors.green.shade200;
        _visibilityApr = false;}
        if(element.month == '05')
        {_feeMay = element.fee;
        _colorMay = Colors.green.shade200;
        _visibilityMay = false;}
        if(element.month == '06')
        {_feeJun = element.fee;
        _colorJun = Colors.green.shade200;
        _visibilityJun = false;}
        if(element.month == '07')
        {_feeJly = element.fee;
        _colorJly = Colors.green.shade200;
        _visibilityJly = false;}
        if(element.month == '08')
        {_feeAug = element.fee;
        _colorAug = Colors.green.shade200;
        _visibilityAug = false;}
        if(element.month == '09')
        {_feeSep = element.fee;
        _colorSep = Colors.green.shade200;
        _visibilitySep = false;}
        if(element.month == '10')
        {_feeOct = element.fee;
        _colorOct = Colors.green.shade200;
        _visibilityOct = false;}
        if(element.month == '11')
        {_feeNov = element.fee;
        _colorNov = Colors.green.shade200;
        _visibilityNov = false;}
        if(element.month == '12')
        {_feeDec = element.fee;
        _colorDec = Colors.green.shade200;
        _visibilityDec = false;}
        if(element.month == '01')
        {_feeJan = element.fee;
        _colorJan = Colors.green.shade200;
        _visibilityJan = false;}
        if(element.month == '02')
        {_feeFeb = element.fee;
        _colorFeb = Colors.green.shade200;
        _visibilityFeb = false;}
        if(element.month == '03')
        {_feeMar = element.fee;
        _colorMar = Colors.green.shade200;
        _visibilityMar = false;}
      });
      _isLoading = false;
    });
  }
  //
  void _initMonthFee(){
    _feeApr = widget.subjectFee;
    _feeMay = widget.subjectFee;
    _feeJun = widget.subjectFee;
    _feeJly = widget.subjectFee;
    _feeAug = widget.subjectFee;
    _feeSep = widget.subjectFee;
    _feeOct = widget.subjectFee;
    _feeNov = widget.subjectFee;
    _feeDec = widget.subjectFee;
    _feeJan = widget.subjectFee;
    _feeFeb = widget.subjectFee;
    _feeMar = widget.subjectFee;
  }
  //
  getSelectedMonth(){
    _selectedMonth.clear();
    if(_aprSwitchValue){
      _selectedMonth.add(MonthList('04', _feeApr));
    }
    if(_maySwitchValue){
      _selectedMonth.add(MonthList('05', _feeMay));
    }
    if(_junSwitchValue){
      _selectedMonth.add(MonthList('06', _feeJun));
    }
    if(_jlySwitchValue){
      _selectedMonth.add(MonthList('07', _feeJly));
    }
    if(_augSwitchValue){
      _selectedMonth.add(MonthList('08', _feeAug));
    }
    if(_sepSwitchValue){
      _selectedMonth.add(MonthList('09', _feeSep));
    }
    if(_octSwitchValue){
      _selectedMonth.add(MonthList('10', _feeOct));
    }
    if(_novSwitchValue){
      _selectedMonth.add(MonthList('11', _feeNov));
    }
    if(_decSwitchValue){
      _selectedMonth.add(MonthList('12', _feeDec));
    }
    if(_janSwitchValue){
      _selectedMonth.add(MonthList('01', _feeJan));
    }
    if(_febSwitchValue){
      _selectedMonth.add(MonthList('02', _feeFeb));
    }
    if(_marSwitchValue){
      _selectedMonth.add(MonthList('03', _feeMar));
    }

  }
  //
  Future<bool> createMonthlyPayment(String jsonMonthList) async{
    try {
      String comment = 'Monthly Payment has received.';
      ProcessPaymentService processPaymentService = ProcessPaymentService();
      dynamic httpResult = await processPaymentService.createMonthlyPayment(kCreateMonthlyPayments,widget.studentID,
          widget.studentName,widget.facultyID,widget.subject,widget.classNbr,_amountNbrStr,comment,jsonMonthList,_modeValue);
      String positiveStatus = 'true';
      //failed as server end
      if(httpResult is String){
        EasyLoading.showToast(httpResult);
        return false;
      }
      //data fetch from server end
      if(httpResult['status'] == positiveStatus){
        //Data created successfully
        EasyLoading.showToast(httpResult['message']);
        return true;
      } else {
        EasyLoading.showToast(httpResult['message']);
        return false;
      }
    } catch (e) {
      EasyLoading.showToast(e.toString());
      return false;
    }
  }
  //
//
}

class DueList {
  final String month,due;
  DueList(this.month,this.due);
}

class PaidList {
  final String month,fee;
  PaidList(this.month,this.fee);
}

class MonthList {
  final String month,fee;
  MonthList(this.month,this.fee);

  Map toJson() => {
    PY002P.monthFld: month,
    PY002P.feeFld: fee,
  };
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