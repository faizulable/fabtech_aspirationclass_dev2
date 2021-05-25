import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/header.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/topHeadline.dart';
import 'package:fabtech_aspirationclass_dev/models/addStudent.dart';
import 'package:fabtech_aspirationclass_dev/screens/addStudent/listWidgetSubject.dart';
import 'package:fabtech_aspirationclass_dev/services/addStudentOpt.dart';
import 'package:fabtech_aspirationclass_dev/models/ST002P.dart';
import 'package:fabtech_aspirationclass_dev/utilites/constantValue.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/progress.dart';
import 'package:fabtech_aspirationclass_dev/customPainter/LabelCustomPainter.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/BaseContainerL.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/BaseContainerR.dart';
import 'package:fabtech_aspirationclass_dev/utilites/getDate.dart';

class AddPageTwo extends StatefulWidget {
  final AddStudentPersonalDetails addstudentPerDtls;
  AddPageTwo({this.addstudentPerDtls});
  @override
  _AddPageTwoState createState() => _AddPageTwoState();
}

class _AddPageTwoState extends State<AddPageTwo> {

  String  _totalAmountStr = '000';
  String _totalDuesStr = '000';
  String _subjectCount = '0';
  bool _isLoading = true;
  List<SubjectList> subjectList =[];
  List<FacultyList> facultyList =[];
  List<String> dropDownFacultyNameList =[];
  List<String> dropDownSubjectList =[];



  @override
  void initState() {
    dropDownFacultyNameList.add('Select teacher');
    dropDownSubjectList.add('Select teacher above');
    getFacultyList(widget.addstudentPerDtls.classNum);
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            topContainer(widget.addstudentPerDtls.name,'CLASS '+widget.addstudentPerDtls.classNum),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5,horizontal: 7),
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
              height: 40.0,
              decoration: BoxDecoration(
                color: Colors.teal.shade100,
                borderRadius: BorderRadius.all(Radius.circular(25)),
                shape: BoxShape.rectangle,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Sub. Count: ',
                      style: amountHeadingTextStyle),
                  Text(_subjectCount,
                      style: amountValueTextStyle),
                  SizedBox(width: 15),
                  Text('Total Amt: ',
                      style: amountHeadingTextStyle),
                  Text(_totalAmountStr,
                      style: amountValueTextStyle),
                  SizedBox(width: 15),
                  Text('Total Dues: ',
                      style: amountHeadingTextStyle),
                  Text(_totalDuesStr,
                      style: amountValueTextStyle),
                ],
              ),
            ),
            Expanded(
              child: _isLoading ? circularProgress() : Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                      child: ListView.builder(
                        itemCount: subjectList.length,
                        itemBuilder:(BuildContext context, int index) {
                          return Dismissible(
                            key: UniqueKey(),
                            background: _myHiddenContainer(index),
                            onDismissed: (direction){
                              if(direction == DismissDirection.startToEnd ) {
                                int totalAmount = int.parse(_totalAmountStr);
                                int totalDues = int.parse(_totalDuesStr);
                                totalAmount = totalAmount - int.parse(subjectList[index].fee);
                                totalDues = totalDues - int.parse(subjectList[index].due);
                                //if(subjectList.contains(subjectList.removeAt(index))) {
                                  setState(() {
                                     subjectList.removeAt(index);
                                    _totalDuesStr = totalDues.toString();
                                    _totalAmountStr = totalAmount.toString();
                                    _subjectCount = subjectList.length.toString();
                                  });
                                //}
                              }
                              if(direction == DismissDirection.endToStart ) {
                                int totalAmount = int.parse(_totalAmountStr);
                                int totalDues = int.parse(_totalDuesStr);
                                totalAmount = totalAmount - int.parse(subjectList[index].fee);
                                totalDues = totalDues - int.parse(subjectList[index].due);
                                //if(subjectList.contains(subjectList.removeAt(index))) {
                                  setState(() {
                                     subjectList.removeAt(index);
                                    _totalDuesStr = totalDues.toString();
                                    _totalAmountStr = totalAmount.toString();
                                    _subjectCount = subjectList.length.toString();
                                  });
                                //}
                              }
                            },
                            child: ListSubjectWidget(facultyId: subjectList[index].facultyId,subject: subjectList[index].subject,
                                fee: subjectList[index].fee,due: subjectList[index].due,dateOfEnrol: subjectList[index].dateOfenrol),
                          );
                        },
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: FloatingActionButton(
                        child: Icon(Icons.add),
                        onPressed: () async {
                          int totalAmount = 0;
                          int totalDues = 0;
                          await _showAddSubjectDialog();
                          dropDownSubjectList.clear();
                          for(int indx=0; indx<subjectList.length;indx++){
                            totalAmount = totalAmount + int.parse(subjectList[indx].fee);
                            totalDues = totalDues + int.parse(subjectList[indx].due);
                          }
                          setState(() {
                            _totalAmountStr = totalAmount.toString();
                            _totalDuesStr = totalDues.toString();
                            _subjectCount = subjectList.length.toString();
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 100.0),
              height: 60,
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
                },
              ),
            ),
            SizedBox(height: 5.0),
          ],
        ),
      ),
    );
  }

//Method to get the list of teachers, currently preset in the class
  getFacultyList(String classNumber) async {
    try {
      AddStudentOpt addStudentOpt = AddStudentOpt(classNbr: classNumber);
      dynamic httpResult = await addStudentOpt.getFactultyList(kAddStudentOptions, 'Two');
      String positiveStatus = 'true';
      //failed as server end
      if(httpResult is String){
        EasyLoading.showToast(httpResult);
      }
      //data fetch from server end
      if(httpResult['status'] == positiveStatus){
        //Data is fetch successfully
        httpResult['data'].forEach((element){
          facultyList.add(FacultyList(element[ST002P.facultyIdFld], element[ST002P.subjectFld]));
          if(!dropDownFacultyNameList.contains(element[ST002P.facultyIdFld])){
            dropDownFacultyNameList.add(element[ST002P.facultyIdFld]);
          }
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
//Window to ask user for new subject:
  Future<void> _showAddSubjectDialog() {
    String windowFees,windowSubject,windowFaculty,windowDue;
    String dateValue = widget.addstudentPerDtls.dateOfAdd;
    bool onChangeEnable =  true;
    final formKey = GlobalKey<FormState>();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, StateSetter setState){
          return AlertDialog(
            contentPadding: EdgeInsets.all(5.0),
            backgroundColor: Colors.teal.shade100,
            title: Center(
              child: Text(
                'ADD SUBJECT',
                style: mainHeadingTextStyle,
              ),
            ),
            content: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(2.0),
                      child: BaseContainerRight(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomPaint(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Center(
                                  child: Text('Faculty',
                                    style: headingTextStyle,
                                  ),
                                ),
                              ),
                              painter: RPSCustomPainter(
                              ),
                            ),
                            DropdownButton(
                              value: windowFaculty,
                              onChanged: onChangeEnable ? (newValue) {
                                setState(() {
                                  windowFaculty = newValue;
                                  for(final element in facultyList){
                                    if(element.facultyID == newValue) {
                                      if(!dropDownSubjectList.contains(element.subject)){
                                        dropDownSubjectList.add(element.subject);
                                      }
                                    }
                                  }
                                });
                                onChangeEnable = false;
                              } : null,
                              items: dropDownFacultyNameList.map((item) {
                                return DropdownMenuItem(
                                  child: Text(item),
                                  value: item,
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: EdgeInsets.all(2.0),
                      child: BaseContainerLeft(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomPaint(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Center(
                                  child: Text('Subject',
                                    style: headingTextStyle,
                                  ),
                                ),
                              ),
                              painter: RPSCustomPainter(
                              ),
                            ),
                            DropdownButton(
                              value: windowSubject,
                              onChanged: (newValue) {
                                setState(() {
                                  windowSubject = newValue;
                                });
                              },
                              items: dropDownSubjectList.map((item) {
                                try{
                                  return DropdownMenuItem(
                                    child: Text(item),
                                    value: item,
                                  );
                                }catch(e){
                                  print('Error in dropdown Subjectlist');
                                }
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: EdgeInsets.all(2.0),
                      child: BaseContainerRight(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomPaint(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Center(
                                  child: Text('Fees',
                                    style: headingTextStyle,
                                  ),
                                ),
                              ),
                              painter: RPSCustomPainter(
                              ),
                            ),
                            TextFormField(
                              decoration: inputFeeDecoration,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              onSaved: (input) => windowFees = input,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter fees';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: EdgeInsets.all(2.0),
                      child: BaseContainerLeft(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomPaint(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Center(
                                  child: Text('Dues',
                                    style: headingTextStyle,
                                  ),
                                ),
                              ),
                              painter: RPSCustomPainter(
                              ),
                            ),
                            TextFormField(
                              decoration: inputFeeDecoration,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              onSaved: (input) => windowDue = input,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter 0';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
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
                                  dateValue,
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
                                      dateValue = val;
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
                  ],
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
                child: Text('Add'),
                onPressed: () {
                  if (formKey.currentState.validate()) {
                    formKey.currentState.save();
                    if(windowFaculty == 'Select Teacher' || windowFaculty == '' || windowSubject=='' ||
                        windowFaculty == null || windowSubject==null)
                    {
                      EasyLoading.showToast('Select teacher');
                    }
                    else {
                      setState((){
                        subjectList.add(SubjectList(windowFaculty,windowSubject,windowFees,windowDue,dateValue));
                        Navigator.of(context).pop();
                      });
                    }
                  }
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
// Dismissible swipe view
  Widget _myHiddenContainer(int position){
    return Container(
      height: 100,
      color: Colors.redAccent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
                icon: Icon(Icons.delete),
                color: Colors.white,
                onPressed: (){
                  setState(() {
                    //if required then add code action on swipe
                  });
                }),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
                icon: Icon(Icons.delete),
                color: Colors.white,
                onPressed: (){
                  //if required then add code action on swipe
                }),
          ),
        ],
      ),
    );
  }
//

}

class SubjectList {
  final String facultyId,subject,fee,due,dateOfenrol;
  SubjectList(this.facultyId,this.subject,this.fee,this.due,this.dateOfenrol);
}

class FacultyList {
  final String facultyID,subject;
  FacultyList(this.facultyID,this.subject);
}

//Text Styling
const amountValueTextStyle = TextStyle(
  color: Colors.black54,
  fontSize: 20,
  fontFamily: 'LandasansMedium',
);

const amountHeadingTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 20,
  fontFamily: 'LandasansMedium',
);

const headingTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 25,
  fontFamily: 'yellowRabbit',
);

const mainHeadingTextStyle = TextStyle(
  color: Colors.red,
  fontSize: 25,
  fontFamily: 'yellowRabbit',
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
