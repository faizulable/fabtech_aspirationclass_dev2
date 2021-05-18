import 'package:flutter/material.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/topHeadline.dart';
import 'package:fabtech_aspirationclass_dev/screens/studentDetail/subject/listWidgetSubject.dart';
import 'package:fabtech_aspirationclass_dev/services/studentDtls.dart';
import 'package:fabtech_aspirationclass_dev/models/appPref.dart';
import 'package:fabtech_aspirationclass_dev/main.dart';
import 'package:fabtech_aspirationclass_dev/utilites/constantValue.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fabtech_aspirationclass_dev/models/ST002P.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/progress.dart';

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

  @override
  void initState() {
    super.initState();
    subjectList = [];
    getStudentSubjectDtls();
    /*subjectList.add(SubjectList('FACULT0000','MATHS','300','0','05/21'));
    subjectList.add(SubjectList('FACULT0000','PHYSICS','300','300','05/21'));
    subjectList.add(SubjectList('FACULT0000','CHEMISTRY','300','0','05/21'));
    subjectList.add(SubjectList('FACULT0000','COMPUTER','300','0','05/21'));*/
  }

  getStudentSubjectDtls () async {
    int totalAmount = 0;
    int totalDues = 0;
    try{
      StudentDtlsService studentDtlsService = StudentDtlsService(branchId: sp.getString(AppPref.userIdPref),
          classNum: widget.classNumStr,studentId: widget.studentIdStr);
      dynamic httpResult = await studentDtlsService.selectStudentSubjectDtls(kSelectStudentSubjectDetails);
      String possitiveStatus = 'true';
      //failed as server end
      if(httpResult is String){
        EasyLoading.showToast(httpResult);
      }
      //data fetch from server end
      if(httpResult['status'] == possitiveStatus) {
        //Data i-s fetch successfully
        httpResult['data'].forEach((element){
          subjectList.add(SubjectList(element[ST002P.facultyIdFld], element[ST002P.subjectFld], element[ST002P.feeFld],
              element[ST002P.dueFld], element[ST002P.dateOfEnrolFld]));
          totalAmount = totalAmount + int.parse(element[ST002P.feeFld]);
          totalDues = totalDues + int.parse(element[ST002P.dueFld]);
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
            child: _isloading ? circularProgress() : Container(
              padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
              child: ListView.builder(
                itemCount: subjectList.length,
                itemBuilder:(BuildContext context, int index) {
                  return ListSubjectWidget(facultyId: subjectList[index].facultyId,subject: subjectList[index].subject,
                  fee: subjectList[index].fee,due: subjectList[index].due,dateOfEnrol: subjectList[index].dateOfenrol);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SubjectList {
  final String facultyId,subject,fee,due,dateOfenrol;
  SubjectList(this.facultyId,this.subject,this.fee,this.due,this.dateOfenrol);
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

