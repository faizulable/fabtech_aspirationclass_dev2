import 'package:fabtech_aspirationclass_dev/models/appPref.dart';
import 'package:fabtech_aspirationclass_dev/utilites/constantValue.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/header.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/topHeadline.dart';
import 'package:fabtech_aspirationclass_dev/main.dart';
import 'package:fabtech_aspirationclass_dev/customPainter/LabelCustomPainter.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/BaseContainerL.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/BaseContainerR.dart';
import 'package:fabtech_aspirationclass_dev/utilites/stringListValues.dart';
import 'package:fabtech_aspirationclass_dev/utilites/getDate.dart';
import 'package:fabtech_aspirationclass_dev/services/addStudentOpt.dart';
import 'package:fabtech_aspirationclass_dev/models/ST001P.dart';
import 'package:fabtech_aspirationclass_dev/models/addStudent.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/progress.dart';
import 'package:fabtech_aspirationclass_dev/screens/addStudent/addPageTwo.dart';
import 'package:intl/intl.dart';


class AddPageOne extends StatefulWidget {
  final String classNumStr;
  AddPageOne({this.classNumStr});

  @override
  _AddPageOneState createState() => _AddPageOneState();
}

class _AddPageOneState extends State<AddPageOne> {

  final _formKey = GlobalKey<FormState>();
  String _genderValue = genderList[0];
  String _dateValue = 'DD/MM/YY';
  String _nameStr,_schoolStr,_boardStr,_admFeeStr,_contactNbrStr,_emailIdStr;
  DateTime _now = DateTime.now();
  List<SchoolList> _schoolList;
  List<String> _viewList;
  bool _isLoading = true;
  bool _viewListbool = false;

  //controller for the edit text
  TextEditingController schoolController = TextEditingController();
  TextEditingController boardController = TextEditingController();

  @override
  void initState() {
    //init the array as empty;
    _schoolList =[];
    _viewList = [];
    //Set admission date to today's date
    var formatter = new DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(_now);
    setState(() {
      _dateValue = formattedDate;
    });
    //Call method to get the list of schools
    getSchoolList(widget.classNumStr);
    super.initState();
  }

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
        child: _isLoading ? circularProgress() : Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
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
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Cannot be blank';
                                    }
                                    if (value.length > 50) {
                                      return 'Cannot be move than 50';
                                    }
                                    return null;
                                  },
                                  onSaved: (input) => _nameStr = input,
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
                                  controller: schoolController,
                                  decoration: inputSchoolDecoration,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Cannot be blank';
                                    }
                                    if (value.length > 50) {
                                      return 'Cannot be move than 50';
                                    }
                                    return null;
                                  },
                                  onSaved: (input) => _schoolStr = input,
                                  onChanged: (value) {
                                    filerSearchResult(value);
                                  },
                                ),
                              ),
                              _viewListbool ? Container(
                                height: 200.0,
                                child: ListView.builder(
                                  itemCount: _viewList.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(
                                        _viewList[index],
                                        style: amountHeadingTextStyle,
                                      ),
                                      onTap: (){
                                        //set the value for the school and board
                                        schoolController.text = _viewList[index];
                                        for(final element in _schoolList){
                                          if(element.school == _viewList[index]){
                                            boardController.text = element.board;
                                            break;
                                          }
                                        }
                                        setState(() {
                                          _viewListbool = false;
                                        });
                                      },
                                    );
                                  },
                                ),
                              )
                                  : Container(),
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
                                      controller: boardController,
                                      decoration: inputBoardDecoration,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Cannot be blank';
                                        }
                                        if (value.length > 10) {
                                          return 'Cannot be move than 10';
                                        }
                                        return null;
                                      },
                                      onSaved: (input) => _boardStr = input,
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
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Cannot be blank';
                                        }
                                        if (value.length > 5) {
                                          return 'Cannot be move than 5';
                                        }
                                        return null;
                                      },
                                      onSaved: (input) => _admFeeStr = input,
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
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Cannot be blank';
                                        }
                                        if (value.length > 10) {
                                          return 'Invalid Contact#';
                                        }
                                        return null;
                                      },
                                      onSaved: (input) => _contactNbrStr = input,
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
                                  onSaved: (input) => _emailIdStr = input,
                                ),
                              ),
                              SizedBox(height: 5.0),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 5.0),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 15.0),
                child: FloatingActionButton(
                  child: Icon(Icons.navigate_next, size: 50.0,),
                  onPressed: () async {
                    if (_formKey.currentState.validate()){
                      _formKey.currentState.save();
                      String emailId = _emailIdStr ?? '';
                      AddStudentPersonalDetails addStudPerDetails = AddStudentPersonalDetails(_nameStr, widget.classNumStr,
                          _schoolStr, _boardStr, _admFeeStr, _dateValue, _contactNbrStr, _genderValue, emailId);
                      bool result = await Navigator.push(context, MaterialPageRoute(builder: (context){
                        return AddPageTwo(addstudentPerDtls: addStudPerDetails);
                      })) ?? false;

                      // if record is added successfully, then exit the screen
                      if(result){
                        Navigator.pop(context,result);
                      }
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Method to get the list of school, currently preset in the coaching center
  getSchoolList(String classNumber) async {
    try {
      AddStudentOpt addStudentOpt = AddStudentOpt(classNbr: classNumber);
      dynamic httpResult = await addStudentOpt.getSchoolList(kAddStudentOptions, 'One');
      String positiveStatus = 'true';
      //failed as server end
      if(httpResult is String){
        EasyLoading.showToast(httpResult);
      }
      //data fetch from server end
      if(httpResult['status'] == positiveStatus){
        //Data is fetch successfully
        httpResult['data'].forEach((element){
          _schoolList.add(SchoolList(element[ST001P.schoolFld], element[ST001P.boardFld]));
        });
      }
  } catch (e) {
      EasyLoading.showToast(e);
    }
    //finally hide the progress bar
    setState(() {
      _isLoading = false;
    });
  }
  //
  //Method to search for the school
  void filerSearchResult(String query) {
    if (_schoolList.isNotEmpty) {
      if (query.isNotEmpty) {
        List<String> dummyList = [];
        _schoolList.forEach((element) {
          if (element.school.toUpperCase().contains(query.toUpperCase())) {
            dummyList.add(element.school);
          }
        });
        setState(() {
          if (dummyList.isNotEmpty) {
            _viewList.clear();
            _viewList.addAll(dummyList);
            _viewListbool = true;
          } else {
            _viewList.clear();
            _viewListbool = false;
          }
        });
      } else {
        setState(() {
          _viewList.clear();
          _viewListbool = false;
        });
      }
    }
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

class SchoolList {
  final String school,board;
  SchoolList(this.school,this.board);
}