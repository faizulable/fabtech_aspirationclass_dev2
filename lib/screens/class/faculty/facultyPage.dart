import 'package:flutter/material.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/header.dart';
import 'package:fabtech_aspirationclass_dev/services/classFacultyList.dart';
import 'package:fabtech_aspirationclass_dev/main.dart';
import 'package:fabtech_aspirationclass_dev/models/appPref.dart';
import 'package:fabtech_aspirationclass_dev/utilites/constantValue.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fabtech_aspirationclass_dev/models/FC001P.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/progress.dart';
import 'package:fabtech_aspirationclass_dev/screens/class/faculty/listWidgetFac.dart';
import 'package:fabtech_aspirationclass_dev/screens/facultyDetail/facultyMainDetail.dart';


class FacultyPage extends StatefulWidget {
  final String classNum;
  FacultyPage({this.classNum});
  @override
  _FacultyPageState createState() => _FacultyPageState();
}

class _FacultyPageState extends State<FacultyPage> {
  List<FacultyList> facultyList;
  List<FacultyList> facultyViewList;
  bool _isloading = true;

  @override
  void initState() {
    super.initState();
    facultyList =[];
    facultyViewList =[];
    getFacultyList();
  }

  getFacultyList() async {
    facultyList.clear();
    facultyViewList.clear();
    try
    {
      ClassFacultyListService classFacultyListService = ClassFacultyListService(branchId: sp.getString(AppPref.userIdPref),classNum: widget.classNum);
      dynamic httpResult = await classFacultyListService.selectFacultyReq(kClassSelectFaculty);
      String possitiveStatus = 'true';
      //failed as server end
      if(httpResult is String){
        EasyLoading.showToast(httpResult);
      }
      //data fetch from server end
      if(httpResult['status'] == possitiveStatus) {
        //Data i-s fetch successfully
        httpResult['data'].forEach((element){
          facultyList.add(FacultyList(element[FC001P.facultyFld],element[FC001P.nameFld],element[FC001P.subjectFld],
              element[FC001P.contactNumberFld],element[FC001P.perShareFacultyFld],element[FC001P.perShareBranchFld]));
        });
        facultyViewList.addAll(facultyList);
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, 'Faculty'),
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
            Container(
              margin: EdgeInsets.symmetric(vertical: 5,horizontal: 7),
              height: 110.0,
              decoration: BoxDecoration(
                color: Colors.teal.shade100,
                borderRadius: BorderRadius.all(Radius.circular(25)),
                shape: BoxShape.rectangle,
              ),
              child: SingleChildScrollView(
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5,horizontal: 5.0),
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          image: DecorationImage(
                              image: AssetImage('images/emblame.png'),
                              fit: BoxFit.fill
                          ),
                          shape: BoxShape.circle
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Center(
                                child: Text('CLASS ' + widget.classNum,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontFamily: 'LemonMilkBold',
                                  ),
                                ),
                              ),
                              width: 280.0,
                            ),
                            Container(
                              width: 250,
                              child: Center(
                                child: Text(sp.getString(AppPref.userNamePref),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'LandasansMedium',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
              child: Center(
                child: TextFormField(
                  decoration: inputFacultyNameDecoration,
                  onChanged: (value){
                    filerSearchResult(value);
                  },
                ),
              ),
            ),
            Expanded(
              child: _isloading ? circularProgress() : ListView.builder(
                itemCount: facultyViewList.length,
                itemBuilder: (BuildContext context, int index){
                  return GestureDetector(
                    child: ListWidgetFac(facultyId: facultyViewList[index].facultyId,name: facultyViewList[index].name,
                        subject: facultyViewList[index].subject, contact: facultyViewList[index].contact,
                        perFacultyShare: facultyViewList[index].perFacultyShare,perBranchShare: facultyViewList[index].perBranchShare),
                    onTap: (){
                      //Navigate to new page
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return FacultyMainDetail(classNum: widget.classNum,
                          subject: facultyViewList[index].subject,facultyName: facultyViewList[index].name,
                        facultyId: facultyViewList[index].facultyId);
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

  //method to filter using Faculty Name
  void filerSearchResult(String query){
    if(facultyList.isNotEmpty){
      if(query.isNotEmpty){
        List<FacultyList> dummyList = [];
        facultyList.forEach((element) {
          if(element.name.toUpperCase().contains(query.toUpperCase())){
            dummyList.add(element);
          }
        });
        setState(() {
          if(dummyList.isNotEmpty){
            facultyViewList.clear();
            facultyViewList.addAll(dummyList);
          } else{
            facultyViewList.clear();
            facultyViewList.addAll(facultyList);
          }
        });
      } else {
        setState(() {
          facultyViewList.clear();
          facultyViewList.addAll(facultyList);
        });
      }
    }
  }

}

class FacultyList
{
  final String facultyId,name,subject,contact,perFacultyShare,perBranchShare;
  FacultyList(this.facultyId,this.name,this.subject,this.contact,
      this.perFacultyShare,this.perBranchShare);
}
