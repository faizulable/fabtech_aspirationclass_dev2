import 'package:flutter/material.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/topHeadline.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/progress.dart';
import 'package:fabtech_aspirationclass_dev/screens/facultyDetail/facultyDues/dueWidget.dart';
import 'package:fabtech_aspirationclass_dev/services/classFacultyStdList.dart';
import 'package:fabtech_aspirationclass_dev/models/appPref.dart';
import 'package:fabtech_aspirationclass_dev/main.dart';
import 'package:fabtech_aspirationclass_dev/utilites/constantValue.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fabtech_aspirationclass_dev/models/PY002P.dart';

class FacultyDueTab extends StatefulWidget {
  final String classNum,subject,facultyName,facultyId;
  FacultyDueTab({this.classNum,this.subject,this.facultyName,this.facultyId});
  @override
  _FacultyDueTabState createState() => _FacultyDueTabState();
}

class _FacultyDueTabState extends State<FacultyDueTab> {
  String _amountStr = '00000';
  bool _isLoading = true;
  List<DueList> _dueList = [];

  @override
  void initState() {
    //now call the method to get list from the server
/*     _dueList.add(DueList('SNKSUH6415','Sharuk Khan','05','2021-2022','240'));
     _dueList.add(DueList('SNKSUH6415','Sharuk Khan','05','2021-2022','240'));
     _dueList.add(DueList('SNKSUH6415','Sharuk Khan','05','2021-2022','240'));
     _dueList.add(DueList('SNKSUH6415','Sharuk Khan','05','2021-2022','240'));
     _dueList.add(DueList('SNKSUH6415','Sharuk Khan','05','2021-2022','240'));
     _dueList.add(DueList('SNKSUH6415','Sharuk Khan','05','2021-2022','240'));*/
    getDueDetails();
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          topContainer(widget.facultyName,'CLASS ' + widget.classNum + ' DUES'),
      Container(
          margin: EdgeInsets.symmetric(vertical: 5,horizontal: 7),
          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
          decoration: BoxDecoration(
            color: Colors.teal.shade100,
            borderRadius: BorderRadius.all(Radius.circular(25)),
            shape: BoxShape.rectangle,
          ),
          child: Center(
            child: Text(
              'Total Dues : ' + _amountStr,
              style: amountValueTextStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              ),
          ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5,horizontal: 7),
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.all(Radius.circular(25)),
              shape: BoxShape.rectangle,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 120.0,
                  child: Center(
                    child: Text(
                      'STD-ID',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: amountHeadingTextStyle,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Text(
                      'DETAILS',
                      style: amountHeadingTextStyle,
                    ),
                  ),
                ),
                Container(
                  width: 100.0,
                  child: Center(
                    child: Text(
                      'AMOUNT',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: amountHeadingTextStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _isLoading ?  circularProgress() : ListView.builder(
              itemCount: _dueList.length,
              itemBuilder: (BuildContext context, int index){
                return DueWidget(studentId: _dueList[index].studentId,name: _dueList[index].name,
                    month: _dueList[index].month,fees: _dueList[index].fee, session: _dueList[index].session);
              },
            ),
          ),
        ],
      ),
    );
  }
  //
  getDueDetails() async {
    int totalAmount = 0;
    _dueList.clear();
    try{
      ClassFacultyStdListService classFacultyStdListService = ClassFacultyStdListService(branchId: sp.getString(AppPref.userIdPref),
          classNum: widget.classNum,facultyId: widget.facultyId,subject: widget.subject);
      dynamic httpResult = await classFacultyStdListService.selectFacultyDues(kgetFacultyDues);
      String positiveStatus = 'true';
      //failed as server end
      if(httpResult is String){
        EasyLoading.showToast(httpResult);
      }
      //data fetch from server end
      if(httpResult['status'] == positiveStatus) {
        //Data is fetch successfully
        httpResult['Data'].forEach((element){
          _dueList.add(DueList(element[PY002P.studentIDFld], element['NAME'], element[PY002P.monthFld],
              element[PY002P.sessionFld],element[PY002P.perShareFacultyFld]));
          totalAmount = totalAmount + int.parse(element[PY002P.perShareFacultyFld]);
        });
      }
      else {
        EasyLoading.showToast(httpResult['message']);
      }
    } catch (e) {
      EasyLoading.showToast(e.toString());
      setState(() {
        _isLoading = false;
        _amountStr = totalAmount.toString();
      });
    }
    //finally hide the progress bar
    setState(() {
      _isLoading = false;
      _amountStr = totalAmount.toString();
    });
  }
}

class DueList
{
  final String studentId,name,month,session,fee;
  DueList(this.studentId,this.name,this.month,this.session,this.fee);
}



const amountValueTextStyle = TextStyle(
  color: Colors.black54,
  fontSize: 30,
  fontFamily: 'LandasansMedium',
);

const amountHeadingTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 20,
  fontFamily: 'Swansea',
);