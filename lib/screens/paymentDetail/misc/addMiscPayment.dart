import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/topHeadline.dart';
import 'package:fabtech_aspirationclass_dev/customPainter/LabelCustomPainter.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/BaseContainerL.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/BaseContainerR.dart';
import 'package:flutter/services.dart';
import 'package:fabtech_aspirationclass_dev/services/processPayment.dart';
import 'package:fabtech_aspirationclass_dev/utilites/getConfirmation.dart';
import 'package:fabtech_aspirationclass_dev/main.dart';
import 'package:fabtech_aspirationclass_dev/models/appPref.dart';
import 'package:fabtech_aspirationclass_dev/utilites/stringListValues.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fabtech_aspirationclass_dev/utilites/constantValue.dart';


class AddMiscPayment extends StatefulWidget {

  final String facultyID,subject,studentName,studentID,classNumber;
  AddMiscPayment({this.facultyID,this.subject,this.studentID,this.studentName,this.classNumber});

  @override
  _AddMiscPaymentState createState() => _AddMiscPaymentState();
}

class _AddMiscPaymentState extends State<AddMiscPayment> {

  String _amountNbrStr,_commentStr;
  final _formKey = GlobalKey<FormState>();
  String _modeValue = modeList[0];
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
          topContainer('MISC PAYMENT',widget.studentName),
          Expanded(
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      child: SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  padding: EdgeInsets.all(2.0),
                                  child: BaseContainerRight(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        CustomPaint(
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Center(
                                              child: Text('Academic Session',
                                                style: headingTextStyle,
                                              ),
                                            ),
                                          ),
                                          painter: RPSCustomPainter(
                                          ),
                                        ),
                                        SizedBox(height: 5.0),
                                        Center(
                                          child: Text( sp.getString(AppPref.sessionPref),
                                            style: amountHeadingTextStyle,
                                          ),
                                        ),
                                        SizedBox(height: 5.0),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  padding: EdgeInsets.all(2.0),
                                  child: BaseContainerRight(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        CustomPaint(
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Center(
                                              child: Text('Subject',
                                                style: headingTextStyle,
                                              ),
                                            ),
                                          ),
                                          painter: RPSCustomPainter(
                                          ),
                                        ),
                                        SizedBox(height: 5.0),
                                        Center(
                                          child: Text( widget.subject,
                                            style: amountHeadingTextStyle,
                                          ),
                                        ),
                                        SizedBox(height: 5.0),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  padding: EdgeInsets.all(2.0),
                                  child: BaseContainerLeft(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width/2 -30,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              CustomPaint(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Center(
                                                    child: Text('Amount',
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
                                          width: MediaQuery.of(context).size.width/2 -30,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  padding: EdgeInsets.all(2.0),
                                  child: BaseContainerLeft(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        CustomPaint(
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Center(
                                              child: Text('Detail Comment',
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
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'Cannot be blank';
                                              }
                                              if (value.length > 100) {
                                                return 'cannot be more than 100 words';
                                              }
                                              return null;
                                            },
                                            onSaved: (input) => _commentStr = input,
                                          ),
                                        ),
                                        SizedBox(height: 5.0),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5.0),
                                height: 60,
                                width: 200,
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
                                    if (_formKey.currentState.validate()){
                                      _formKey.currentState.save();
                                      bool confirm = await confirmationDialog(context,'Do you want to save this miscellaneous transaction ?');
                                      if(confirm){
                                        bool result = await createMiscPayment();
                                        if(result){
                                          Navigator.pop(context);
                                        }
                                      }
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: FloatingActionButton(
                        child: Icon(Icons.navigate_before),
                        onPressed: () {
                          //go back
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
          ),
        ],
      ),
    );
  }
  //
  Future<bool> createMiscPayment() async{
    try {
      ProcessPaymentService processPaymentService = ProcessPaymentService();
      dynamic httpResult = await processPaymentService.createMiscPayment(kCreateMiscPayments,widget.studentID,
          widget.studentName,widget.facultyID,widget.subject,widget.classNumber,_amountNbrStr,_commentStr,'MS',_modeValue);
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

const inputEmailDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  hintText: 'Enter detail about the payment',
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