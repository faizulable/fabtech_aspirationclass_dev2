import 'package:flutter/material.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/topHeadline.dart';
import 'package:fabtech_aspirationclass_dev/services/classFacultyStdList.dart';
import 'package:fabtech_aspirationclass_dev/main.dart';
import 'package:fabtech_aspirationclass_dev/models/appPref.dart';
import 'package:fabtech_aspirationclass_dev/utilites/constantValue.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fabtech_aspirationclass_dev/models/ST001P.dart';
import 'package:fabtech_aspirationclass_dev/models/ST002P.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/progress.dart';
import 'package:fabtech_aspirationclass_dev/screens/facultyDetail/facultyStudents/listWidgetFacStd.dart';


class FacultyStudentPage extends StatefulWidget {
  final String classNum,subject,facultyName,facultyId;
  FacultyStudentPage({this.classNum,this.subject,this.facultyName,this.facultyId});
  @override
  _FacultyStudentPageState createState() => _FacultyStudentPageState();
}

class _FacultyStudentPageState extends State<FacultyStudentPage> {
  List<StudentList> studentList;
  bool _isloading = true;
  String _totalAmountStr = '0000';
  String _facultyShareStr = '0000';
  String _aspirationShareStr ='0000';
  int _totalAmount,_facultyShare,_aspirationShare;
  
  @override
  void initState() {
    super.initState();
    studentList =[];
    getStudentList();
  }

  getStudentList() async {
    studentList.clear();
    _totalAmount = 0;
    _facultyShare = 0;
    _aspirationShare=0;
    try
    {
      ClassFacultyStdListService fs = ClassFacultyStdListService(branchId: sp.getString(AppPref.userIdPref),classNum: widget.classNum,
      subject: widget.subject,facultyId: widget.facultyId);
      dynamic httpResult = await fs.selectFacultyStdReq(kClassSelectFacultyStd);
      String possitiveStatus = 'true';
      //failed as server end
      if(httpResult is String){
        EasyLoading.showToast(httpResult);
      }
      //data fetch from server end
      if(httpResult['status'] == possitiveStatus) {
        //Data i-s fetch successfully
        httpResult['data'].forEach((element){
          studentList.add(StudentList(element[ST001P.studentIdFld],element[ST001P.nameFld],element[ST001P.genderFld],
              element[ST001P.contactNumberFld],element[ST001P.emailFld],element[ST001P.subjectCountFld],
              element[ST001P.monthlyFeesFld],element[ST001P.duesFld],element[ST002P.feeFld],
          element[ST002P.facShareFld],element[ST002P.aspShareFld]));
          _totalAmount = _totalAmount + int.parse(element[ST002P.feeFld]);
          _facultyShare = _facultyShare + int.parse(element[ST002P.facShareFld]);
          _aspirationShare = _aspirationShare + int.parse(element[ST002P.aspShareFld]);
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
      _totalAmountStr = _totalAmount.toString();
      _facultyShareStr = _facultyShare.toString();
      _aspirationShareStr = _aspirationShare.toString();
    });
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            topContainer(widget.facultyName,'CLASS ' + widget.classNum),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5,horizontal: 7),
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
              decoration: BoxDecoration(
                color: Colors.teal.shade100,
                borderRadius: BorderRadius.all(Radius.circular(25)),
                shape: BoxShape.rectangle,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Total Amt: ',
                  style: amountHeadingTextStyle),
                  Text(_totalAmountStr,
                      style: amountValueTextStyle),
                  SizedBox(width: 5),
                  Text('Faculty Share: ',
                      style: amountHeadingTextStyle),
                  Text(_facultyShareStr,
                      style: amountValueTextStyle),
                  SizedBox(width: 5),
                  Text('Aspiration Share: ',
                      style: amountHeadingTextStyle),
                  Text(_aspirationShareStr,
                      style: amountValueTextStyle),
                ],
              ),
            ),
            Expanded(
              child: _isloading ? circularProgress() : ListView.builder(
                itemCount: studentList.length,
                itemBuilder: (BuildContext context, int index){
                  return ListWidget(studentId: studentList[index].studentId,name: studentList[index].name,
                      contact: studentList[index].contact,monthlyfees: studentList[index].fee);
                },
              ),
            ),
          ],
        ),
      );
  }

}

class StudentList
{
  final String studentId,name,gender,contact,emailId,subjectCount,monthlyfees,dues,fee,facShare,aspShare;
  StudentList(this.studentId,this.name,this.gender,this.contact,
      this.emailId,this.subjectCount,this.monthlyfees,this.dues,this.fee,this.facShare,this.aspShare);
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