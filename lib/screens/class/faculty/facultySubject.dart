import 'package:flutter/material.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/topHeadline.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/header.dart';
import 'package:fabtech_aspirationclass_dev/services/classFacultyList.dart';
import 'package:fabtech_aspirationclass_dev/main.dart';
import 'package:fabtech_aspirationclass_dev/models/appPref.dart';
import 'package:fabtech_aspirationclass_dev/utilites/constantValue.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fabtech_aspirationclass_dev/models/FC001P.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/progress.dart';
import 'package:fabtech_aspirationclass_dev/screens/class/faculty/listWidgetFacSub.dart';
import 'package:fabtech_aspirationclass_dev/screens/facultyDetail/facultyMainDetail.dart';


class FacultySubjectPage extends StatefulWidget {
  final String classNum,facultyName,facultyId,facultyContactNbr;
  FacultySubjectPage({this.classNum,this.facultyName,this.facultyId,this.facultyContactNbr});
  @override
  _FacultySubjectPageState createState() => _FacultySubjectPageState();
}

class _FacultySubjectPageState extends State<FacultySubjectPage> {
  List<SubjectList> _subjectList;
  bool _isloading = true;
  
  @override
  void initState() {
    super.initState();
    _subjectList =[];
    getSubjectList();
  }

  getSubjectList() async {
    _subjectList.clear();
    try
    {
      ClassFacultyListService fs = ClassFacultyListService(branchId: sp.getString(AppPref.userIdPref),classNum: widget.classNum);
      dynamic httpResult = await fs.selectFacultySubject(kGetClassFacultySub,widget.facultyId);
      String possitiveStatus = 'true';
      //failed as server end
      if(httpResult is String){
        EasyLoading.showToast(httpResult);
      }
      //data fetch from server end
      if(httpResult['status'] == possitiveStatus) {
        //Data i-s fetch successfully
        httpResult['data'].forEach((element){
          _subjectList.add(SubjectList(element[FC001P.subjectFld],element[FC001P.perShareFacultyFld],element[FC001P.perShareBranchFld],
              element[FC001P.statusFld]));
        });
      }
      else {
        EasyLoading.showToast(httpResult['message']);
      }
    } catch (e) {
      EasyLoading.showToast(e.toString());
    }
    //finally hide the progress bar
    setState(() {
      _isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, 'CLASS ' + widget.classNum),
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
              topContainer(widget.facultyName, widget.facultyContactNbr),
              Expanded(
                child: _isloading ? circularProgress() : ListView.builder(
                  itemCount: _subjectList.length,
                  itemBuilder: (BuildContext context, int index){
                    return GestureDetector(
                      child: ListWidgetFacSub(subject: _subjectList[index].subject,perFacultyShare: _subjectList[index].facShare,
                          perBranchShare: _subjectList[index].aspShare,status: _subjectList[index].status),
                      onTap: (){
                        //Navigate to new page
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return FacultyMainDetail(classNum: widget.classNum,
                              subject: _subjectList[index].subject,facultyName: widget.facultyName, facultyId: widget.facultyId);
                        }));
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
    );
  }

}

class SubjectList
{
  final String subject,facShare,aspShare,status;
  SubjectList(this.subject,this.facShare,this.aspShare,this.status);
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