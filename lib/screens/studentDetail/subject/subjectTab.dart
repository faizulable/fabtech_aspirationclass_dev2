import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/topHeadline.dart';
import 'package:fabtech_aspirationclass_dev/screens/studentDetail/subject/listWidgetSubject.dart';
import 'package:fabtech_aspirationclass_dev/screens/paymentDetail/dues/dueTab.dart';
import 'package:fabtech_aspirationclass_dev/screens/paymentDetail/misc/addMiscPayment.dart';
import 'package:fabtech_aspirationclass_dev/services/studentDtls.dart';
import 'package:fabtech_aspirationclass_dev/services/addStudentOpt.dart';
import 'package:fabtech_aspirationclass_dev/services/addStudentSubject.dart';
import 'package:fabtech_aspirationclass_dev/models/appPref.dart';
import 'package:fabtech_aspirationclass_dev/main.dart';
import 'package:fabtech_aspirationclass_dev/utilites/constantValue.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fabtech_aspirationclass_dev/models/ST002P.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/progress.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/BaseContainerL.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/BaseContainerR.dart';
import 'package:fabtech_aspirationclass_dev/customPainter/LabelCustomPainter.dart';
import 'package:fabtech_aspirationclass_dev/utilites/getDate.dart';
import 'package:fabtech_aspirationclass_dev/utilites/getConfirmation.dart';

class SubjectTab extends StatefulWidget {
  final String classNumStr,studentIdStr,studnetNameStr;
  SubjectTab({this.classNumStr,this.studentIdStr,this.studnetNameStr});
  @override
  _SubjectTabState createState() => _SubjectTabState();
}

class _SubjectTabState extends State<SubjectTab> {

  bool _isloading = true;
  String  _totalAmountStr = '000';
  String _totalDues = '000';
  String _subjectCount = '0';
  List<SubjectList> subjectList;
  List<FacultyList> facultyList =[];
  List<String> dropDownFacultyNameList =[];
  List<String> dropDownSubjectList =[];
  String formattedDate;
  @override
  void initState() {
    super.initState();
    subjectList = [];
    getStudentSubjectDtls();
    getFacultyList(widget.classNumStr);

    var formatter = new DateFormat('dd-MM-yyyy');
    formattedDate = formatter.format(DateTime.now());
    /*subjectList.add(SubjectList('FACULT0000','MATHS','300','0','05/21'));
    subjectList.add(SubjectList('FACULT0000','PHYSICS','300','300','05/21'));
    subjectList.add(SubjectList('FACULT0000','CHEMISTRY','300','0','05/21'));
    subjectList.add(SubjectList('FACULT0000','COMPUTER','300','0','05/21'));*/
  }

  getStudentSubjectDtls () async {
    int totalAmount = 0;
    int totalDues = 0;
    subjectList.clear();
    try{
      StudentDtlsService studentDtlsService = StudentDtlsService(branchId: sp.getString(AppPref.userIdPref),
          classNum: widget.classNumStr,studentId: widget.studentIdStr);
      dynamic httpResult = await studentDtlsService.selectStudentSubjectDtls(kSelectStudentSubjectDetails);
      String positiveStatus = 'true';
      //failed as server end
      if(httpResult is String){
        EasyLoading.showToast(httpResult);
      }
      //data fetch from server end
      if(httpResult['status'] == positiveStatus) {
        //Data is fetch successfully
        httpResult['data'].forEach((element){
          subjectList.add(SubjectList(element[ST002P.facultyIdFld], element[ST002P.subjectFld], element[ST002P.feeFld],
              element[ST002P.dueFld],element[ST002P.statusFld],element[ST002P.dateOfEnrolFld]));
          if(element[ST002P.statusFld] == 'A'){
            totalAmount = totalAmount + int.parse(element[ST002P.feeFld]);
          }
          if(int.parse(element[ST002P.dueFld]) > 0){
            totalDues = totalDues + int.parse(element[ST002P.dueFld]);
          }
        });
      }
      else {
        EasyLoading.showToast(httpResult['message']);
      }
    } catch (e) {
      EasyLoading.showToast(e);
    }
    //finally hide the progress bar
    setState(() {
      _isloading = false;
      _subjectCount = subjectList.length.toString();
      _totalAmountStr = totalAmount.toString();
      _totalDues = totalDues.toString();
    });
  }

//Method to get the list of teachers, currently preset in the class
  getFacultyList(String classNumber) async {
    //finally hide the progress bar
    setState(() {
      _isloading = true;
    });
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
      _isloading = false;
    });
  }
//

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
          topContainer(widget.studnetNameStr,'CLASS '+widget.classNumStr),
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
                Text(_totalDues,
                    style: amountValueTextStyle),
              ],
            ),
          ),
          Expanded(
            child: _isloading ? circularProgress() :
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                        child: ListView.builder(
                          itemCount: subjectList.length,
                          itemBuilder:(BuildContext context, int index) {
                            return GestureDetector(
                              child: ListSubjectWidget(facultyId: subjectList[index].facultyId,subject: subjectList[index].subject,
                                  fee: subjectList[index].fee,due: subjectList[index].due,status: subjectList[index].status, dateOfEnrol: subjectList[index].dateOfenrol,
                                crossFunction: (){
                                  crossFunction(index);
                                },miscFunction: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return AddMiscPayment(studentName: widget.studnetNameStr,studentID: widget.studentIdStr,
                                        facultyID: subjectList[index].facultyId,subject: subjectList[index].subject,classNumber: widget.classNumStr);
                                  }));
                                },),
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return DueTab(studentName: widget.studnetNameStr,studentId: widget.studentIdStr,
                                  facultyId: subjectList[index].facultyId,subject: subjectList[index].subject,
                                      classNum: widget.classNumStr,subjectFee: subjectList[index].fee);
                                }));
                              },
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
                            //show window to add new subject
                            await _showAddSubjectDialog();
                            dropDownSubjectList.clear();
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
  //Window to ask user for new subject:
  Future<void> _showAddSubjectDialog() {
    String windowFees,windowSubject,windowFaculty,windowDue;
    String dateValue = formattedDate;
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
                      EasyLoading.showToast('Select teacher/subject');
                    }
                    else {
                      //call the method to save the subject details
                      addNewSubject(widget.classNumStr, widget.studentIdStr, windowFaculty, windowSubject,
                          dateValue, windowFees, windowDue);
                      Navigator.of(context).pop();
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
  //Method to create subject record
  addNewSubject(String classNumber,String studentId,String facultyId,String subject,
      String enrolDate, String monthlyFees, String totalDues) async {
    //finally hide the progress bar
    setState(() {
      _isloading = true;
    });
    try {
      AddStudentSubjectService addStudentSubjectService = AddStudentSubjectService();
      dynamic httpResult = await addStudentSubjectService.createSubject(kCreateStudentSubject,studentId,facultyId,
      subject,classNumber,enrolDate,monthlyFees,totalDues);
      String positiveStatus = 'true';
      //failed as server end
      if(httpResult is String){
        EasyLoading.showToast(httpResult);
        setState(() {
          _isloading = false;
        });
      }
      //data fetch from server end
      if(httpResult['status'] == positiveStatus){
        //Data is created successfully
        EasyLoading.showToast(httpResult['message']);
        getStudentSubjectDtls ();
      } else {
        EasyLoading.showToast(httpResult['message']);
        setState(() {
          _isloading = false;
        });
      }
    } catch (e) {
      EasyLoading.showToast(e);
      setState(() {
        _isloading = false;
      });
    }
  }
  //

   crossFunction(int index) async {
    bool confirm = await confirmationDialog(context,'Do you want to remove student from this class ?');
    if(confirm){
      removeSubject(widget.classNumStr,widget.studentIdStr,
          subjectList[index].facultyId,subjectList[index].subject);
    }
  }

//Method to remove subject record
  removeSubject(String classNumber,String studentId,String facultyId,String subject) async {
    //finally hide the progress bar
    setState(() {
      _isloading = true;
    });
    try {
      AddStudentSubjectService addStudentSubjectService = AddStudentSubjectService();
      dynamic httpResult = await addStudentSubjectService.removeSubject(kRemoveStudentSubject,studentId,facultyId,
          subject,classNumber);
      String positiveStatus = 'true';
      //failed as server end
      if(httpResult is String){
        EasyLoading.showToast(httpResult);
        setState(() {
          _isloading = false;
        });
      }
      //data fetch from server end
      if(httpResult['status'] == positiveStatus){
        //Data is updated successfully
        EasyLoading.showToast(httpResult['message']);
        getStudentSubjectDtls ();
      } else {
        EasyLoading.showToast(httpResult['message']);
        setState(() {
          _isloading = false;
        });
      }
    } catch (e) {
      EasyLoading.showToast(e);
      setState(() {
        _isloading = false;
      });
    }
  }
//
}

class SubjectList {
  final String facultyId,subject,fee,due,status,dateOfenrol;
  SubjectList(this.facultyId,this.subject,this.fee,this.due,this.status,this.dateOfenrol);
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

const mainHeadingTextStyle = TextStyle(
  color: Colors.red,
  fontSize: 30,
  fontFamily: 'yellowRabbit',
);

const headingTextStyle = TextStyle(
  color: Colors.white,
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

const windowTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 20,
  fontFamily: 'Swansea',
);
